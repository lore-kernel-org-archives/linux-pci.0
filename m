Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI boot
 for X-Gene v1
To: Loc Ho <lho@apm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1455069384-22323-1-git-send-email-dhdang@apm.com>
 <1456330151.5681.46.camel@redhat.com> <56CDD767.6020103@arm.com>
 <CADaLND=mrkxOWOzcEb8os16Rb=SDHfnn_8eSgB4bQYH3UguS3w@mail.gmail.com>
 <20160225173822.GA6349@red-moon>
 <CADaLNDnywVPER9QhmK4C6JyCLhta_M_cVSOuSkEHnmnLPFo3JA@mail.gmail.com>
 <20160526123459.GA23794@red-moon>
 <CADaLNDnf8SRbUkBN9fZMvrvsnTQs+DLyqnZfVpWqVyyY8Hk=1Q@mail.gmail.com>
 <20160527105238.GA25842@red-moon>
 <CADaLNDkvY_gZwWYfy1dHzBLRwH1S1h3gTN9ib5ixqG4REJuOow@mail.gmail.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <6b577a0e-db39-d2d9-1093-3fb2513c568f@redhat.com>
Date: Wed, 26 Apr 2017 00:17:08 -0400
MIME-Version: 1.0
In-Reply-To: <CADaLNDkvY_gZwWYfy1dHzBLRwH1S1h3gTN9ib5ixqG4REJuOow@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Feng Kan <fkan@apm.com>, rjw@rjwysocki.net,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
 patches <patches@apm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tanmay Inamdar <tinamdar@apm.com>, Mark Salter <msalter@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 06/03/2016 06:15 PM, Duc Dang wrote:

> Do you have other suggestions? Otherwise, I will prepare a patch
> following Lorenzo's approach.

Duc has since left Applied for other pastures. I miss him, he's a great
guy. He laid all the right groundwork for this, but the ACPI binding
still needs to be upstreamed. It's a few lines of code matching on
APMC0D0E but without it, upstream kernels wont have working MSI on
X-Gene with ACPI. I need this to be upstreamed soon please :) Can
someone at APM followup with an updated patch, and get it in?

Here's the rub. The average person booting a Linux box (even a good
kernel person) isn't going to say "hey, MSIs aren't setup right on this
ARM server because it's compliant with 1 out of 3 possible ways MSIs
might be done at a high level [let's forget the many others] and all it
needs is this...". What they're going to say is "huh, PCIe card doesn't
work, might be an MSI problem". Which is the email I have after someone
tried using an IB card in an X-Gene box and spent a few hours poking.

We're so close to having "ACPI all the things" but the latest
development builds of RHEL don't do MSI on X-Gene because of the Red Hat
"upstream first" rules. So let's get that fixed.

Thanks,

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
