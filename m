Return-Path: <SRS0=4H7O=IT=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=4H7O=IT=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V2] PCI: move early dump functionality from x86 arch into
 the common code
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Petr Tesarik <ptesarik@suse.cz>, Ram Pai <linuxram@us.ibm.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Christoffer Dall <cdall@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, David Rientjes <rientjes@google.com>,
 Thymo van Beers <thymovanbeers@gmail.com>, Borislav Petkov <bp@suse.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-arm-msm@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 Dou Liyang <douly.fnst@cn.fujitsu.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>
References: <1527878854-21419-1-git-send-email-okaya@codeaurora.org>
 <20180601185310.GA175802@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <dac3d600-86c4-456a-046b-f2229a8c19d7@codeaurora.org>
Date: Fri, 1 Jun 2018 14:58:48 -0400
MIME-Version: 1.0
In-Reply-To: <20180601185310.GA175802@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 6/1/2018 2:53 PM, Bjorn Helgaas wrote:
>> +	pci_info(pdev, "pci 0000:%02x:%02x.%d config space:\n",
>> +		 pdev->bus->number, PCI_SLOT(pdev->devfn),
>> +		 PCI_FUNC(pdev->devfn));
> I'm still missing something -- why go to the trouble of pdev->bus->number,
> PCI_SLOT(), etc?  Isn't the output going to look like this?
> 
>   pci 0000:00:00.0: pci 0000:00:00.0 config space:
> 
> In other words, wouldn't the following be enough?
> 
>   pci_info(pdev, "config space:\n");
> 

You are right. The origin print function was pr_info. We don't need that
stuff anymore. 

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
