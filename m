Return-Path: <rric.net@gmail.com>
Return-Path: <rric.net@gmail.com>
Sender: Robert Richter <rric.net@gmail.com>
Date: Fri, 22 Jul 2016 14:11:00 +0200
From: Robert Richter <rric@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Christopher Covington <cov@codeaurora.org>,
	Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jayachandran C <jchandra@broadcom.com>,
	Robert Richter <robert.richter@caviumnetworks.com>,
	Marcin Wojtas <mw@semihalf.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Andrea Gallo <andrea.gallo@linaro.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Dongdong Liu <liudongdong3@huawei.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [RFC PATCH v4 3/5] PCI: Check platform specific ECAM quirks
Message-ID: <20160722121100.GN25086@rric.localdomain>
References: <1467100442-28078-1-git-send-email-tn@semihalf.com>
 <1467100442-28078-4-git-send-email-tn@semihalf.com>
 <577275EA.7010002@codeaurora.org>
 <CADaLNDkhPZuG7UJ4SK_j5v_nXbd782Q17LAcXduG0uEObaFF=g@mail.gmail.com>
 <5773A773.8040700@semihalf.com>
 <5773CE49.1050802@codeaurora.org>
 <CAKv+Gu9=0=qw70o1aYNg=tDyv4TguiG2WwXNK8RbWM1-ZcabUg@mail.gmail.com>
 <20160722113809.GM25086@rric.localdomain>
 <CAKv+Gu9jfHGF3Z=_yA2rR9v3MGWptom4x1Mm=eGxmB0xoBpqoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv+Gu9jfHGF3Z=_yA2rR9v3MGWptom4x1Mm=eGxmB0xoBpqoA@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On 22.07.16 14:00:42, Ard Biesheuvel wrote:
> On 22 July 2016 at 13:38, Robert Richter <rric@kernel.org> wrote:

> > And, we should support some sort of MCFG_OEM_REVISION_ANY to move the
> > rev handling optional to pci_cfg_fixup::init().
> >
> 
> xxx_ANY implies 'wildcard', which we don't want in this code. The set
> of quirky hardware we intend to support is known, and wildcard
> matching makes it easier to circumvent our policy that from here on,
> i.e., that all ACPI/arm64 supported hardware shall adhere to the spec.

Fine with me, there shouln't be to many revs around to have a quirk
per rev.

-Robert
