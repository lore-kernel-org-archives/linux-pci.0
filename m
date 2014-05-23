Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <537FBF4F.4050406@amd.com>
Date: Fri, 23 May 2014 16:36:15 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Robert Richter <rric@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Borislav Petkov <bp@alien8.de>,
	Daniel J Blueman <daniel@numascale.com>,
	Andreas Herrmann <herrmann.der.user@googlemail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Aravind Gopalakrishnan" <Aravind.Gopalakrishnan@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH V5 3/4] x86/PCI: Stop enabling ECS for AMD CPUs after
 Fam16h
References: <20140521231615.26447.38060.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140521231817.26447.55150.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140521233802.GA21575@pd.tnic>
 <CAErSpo4hcitey+jtZkgpbZsEswJJekStXONct9rrh0aQ_R0h8g@mail.gmail.com>
 <20140522191746.GL4383@pd.tnic>
 <CAErSpo7=0-xdnu4DQufu_6eS=6AYhnDRaQvzeiMEC5a=zKU0Jg@mail.gmail.com>
 <537E8ACF.6000103@amd.com>
 <CAErSpo6AMGPFELx+2qJXYaxaLRhk2F2J=wn4=gLgmvYGdLup7A@mail.gmail.com>
 <20140523115622.GU27560@rric.localhost>
In-Reply-To: <20140523115622.GU27560@rric.localhost>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/23/2014 6:56 AM, Robert Richter wrote:
> On 22.05.14 20:54:54, Bjorn Helgaas wrote:
>> I'm going to go out on a limb and guess that Windows does not enable
>> ECS, so it probably uses ECAM.  Therefore, I suspect Linux's parsing
>> of MCFG is broken in some way, and we probably *could* use ECAM in all
>> these cases I'm seeing.
>
> Even if ECS is not enabled the system should be fine anyway, as ECS is
> only used to enable certain features. For family 10h this was
> originally the IBS EILVT (extended interrupt local vector table,
> needed for hw profiling) setup which need to be set by the OS which
> the BIOS didn't right. This should be fixed now and properly set by
> the BIOS on 15h+ systems.
>
> I don't remember what was added to 16h where ECS was needed, I think
> there was one (Suravee?). Not sure if this is essential.

I am not aware of anything specific in the family16h which require 
IO_ECS to be enabled.

Suravee

