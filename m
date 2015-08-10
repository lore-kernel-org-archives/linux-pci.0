Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 10 Aug 2015 18:38:09 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Duc Dang <dhdang@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: X-Gene: Unhandled fault: synchronous external abort in
 pci_generic_config_read32
Message-ID: <20150810173809.GE15394@e104818-lin.cambridge.arm.com>
References: <20150724224258.GA23990@google.com>
 <CADaLNDmYZ=8XQt82W_H74QaOiX3UwkVxkE1_EWRgzhkG1boebw@mail.gmail.com>
 <CAErSpo549xfAnx62quCqGHh3DNay5Lfb6EhEG+4EXooEuueQFQ@mail.gmail.com>
 <CADaLNDn95H=g73DKWRsrB4SuWcf+-8mkepbwb_DC-sFsVkrk6g@mail.gmail.com>
 <20150728212944.GA12958@google.com>
 <CADaLNDkOLiyPmVC3VwpnbrfAKFmNwSVJKdChjQFdQqs7XP-Ddg@mail.gmail.com>
 <20150729012255.GA18606@google.com>
 <20150729155509.GA31170@google.com>
 <CADaLNDk=+J_yOer1ferSCNb_xAC42ULtP2FyCLmYMwa+Gj=vfA@mail.gmail.com>
 <CAErSpo4VFh7rv81sCAG-eCXVyZh4ub8Trh-ntZhyfy7BzqTr5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4VFh7rv81sCAG-eCXVyZh4ub8Trh-ntZhyfy7BzqTr5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 10, 2015 at 11:18:23AM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 31, 2015 at 12:00 PM, Duc Dang <dhdang@apm.com> wrote:
> > On Wed, Jul 29, 2015 at 8:55 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> On Tue, Jul 28, 2015 at 08:22:55PM -0500, Bjorn Helgaas wrote:
> >>> On Tue, Jul 28, 2015 at 02:50:39PM -0700, Duc Dang wrote:
> >>
> >>> > Do you have another PCIe card to try on the same reboot test on this board?
> >>>
> >>> I've seen this on at least two Mellanox cards.  I'm running similar tests
> >>> on a different type of card now.
> >>
> >> FWIW, reboot tests on two machines with Mellanox cards failed, while the
> >> same test on a machine with a different proprietary card succeeded.
> >
> > Thanks, Bjorn.
> >
> > I don't have the same Mellanox card as yours, but I will also run
> > similar reboot test to see if I hit the same issue with my card.
> 
> Any more hints on this?  Nothing has changed on my end, so of course
> I'm still seeing this, always on machines with Mellanox, and never on
> other machines.  Could this be a hardware issue like a signal
> integrity or margin issue?  I don't know where to go from here because
> I'm not a hardware person, and I don't know anything to do in
> software.

Silly hack below, not actually a solution (and it may not even work):

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 94d98cd1aad8..e895e96b3d13 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -369,6 +369,14 @@ static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	return 1;
 }
 
+/*
+ * Retry the faulty access.
+ */
+static int do_good(unsigned long addr, unsigned int esr, struct pt_regs *regs)
+{
+	return 0;
+}
+
 static struct fault_info {
 	int	(*fn)(unsigned long addr, unsigned int esr, struct pt_regs *regs);
 	int	sig;
@@ -391,7 +399,7 @@ static struct fault_info {
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 1 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
-	{ do_bad,		SIGBUS,  0,		"synchronous external abort"	},
+	{ do_good,		SIGBUS,  0,		"synchronous external abort"	},
 	{ do_bad,		SIGBUS,  0,		"asynchronous external abort"	},
 	{ do_bad,		SIGBUS,  0,		"unknown 18"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 19"			},

-- 
Catalin
