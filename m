Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sinan Kaya <okaya@codeaurora.org>, jchandra@broadcom.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>, wangyijing@huawei.com, Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>, Linux PCI <linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Jon Masters <jcm@redhat.com>, andrea.gallo@linaro.org, dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com, Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH V7 03/11] pci, of: Move the PCI I/O space management to PCI core code.
Date: Wed, 11 May 2016 13:01:18 +0200
Message-ID: <4722186.M8gaIx9LyT@wuerfel>
In-Reply-To: <5732E11A.9090002@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com> <CAJZ5v0ge+LGwp=AkPF50H1ZXFA6J5ByazuY7Opc-aLJwWrBNxg@mail.gmail.com> <5732E11A.9090002@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 11 May 2016 09:36:58 Tomasz Nowicki wrote:
> >
> > I understand that this moves code around, but those in-function
> > #ifdefs aren't nice.  Any chance to get rid of them but putting whole
> > functions under the #ifdef?
> >
> 
> This is a __weak implementation, so assuming I would move #ifdef out of 
> function I need to provide another empty __weak stub. I do not know 
> which solution is more ugly. In any case we can do that cleanup separately.
> 

I'd vote for just dropping the __weak here, given that there is no
non-weak implementation. If we end up needing to override this for
some architecture or host bridge in the future, we can think about how
to best do that then.

I agree that should be a separate patch, this one should only move
code from one file to another.

	Arnd
