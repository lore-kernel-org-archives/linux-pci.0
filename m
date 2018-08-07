Return-Path: <SRS0=H9HV=KW=linux.intel.com=felipe.balbi@kernel.org>
Return-Path: <SRS0=H9HV=KW=linux.intel.com=felipe.balbi@kernel.org>
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, stable@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] PCI: Fix bit definitions for LNKCAP2 register
In-Reply-To: <20180806182327.GA30691@bhelgaas-glaptop.roam.corp.google.com>
References: <20180803065120.29322-1-felipe.balbi@linux.intel.com> <20180806182327.GA30691@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 07 Aug 2018 11:20:33 +0300
Message-ID: <87lg9ia8q6.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>


Hi,

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Fri, Aug 03, 2018 at 09:51:20AM +0300, Felipe Balbi wrote:
>> Even thhough commit b891b4dc1eed claimed that original bit definitions
>> were wrong, that's not really the case. After verifying PCI
>> Specification Revisions 3.0, 3.1 and 4.0, Link Capabilites 2
>> Register's bit definitions were always starting from Bit 0.
>> 
>> This has been causing issues reporting correct link speeds on sysfs.
>
> Can you elaborate on this a bit?  b891b4dc1eed still looks correct to
> me.  I'm looking at PCIe r4.0, sec 7.5.3.18, where it shows:
>
>   bit    0  RsvdP
>   bits 7:1  Supported Link Speeds Vector

I had missed this detail, actually. It was a misinterpretation of the
spec. Sorry for the noise.

-- 
balbi
