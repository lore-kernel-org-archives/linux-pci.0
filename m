Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
To: Bjorn Helgaas <helgaas@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: poza@codeaurora.org, Thomas Tai <thomas.tai@oracle.com>,
 bhelgaas@google.com, keith.busch@intel.com, linux-pci@vger.kernel.org,
 linux-pci-owner@vger.kernel.org, Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
 <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
 <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
 <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <fe891b63-12c7-61ab-a59a-ae24ad766754@kernel.org>
Date: Sun, 19 Aug 2018 17:41:32 -0400
MIME-Version: 1.0
In-Reply-To: <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 8/18/2018 10:19 PM, Bjorn Helgaas wrote:
>> Bjorn, please revert all of those changes.
> Please send the appropriate patches and we'll go from there.
> 

I'm also catching up on this thread.

I don't think revert is the way to go. There is certainly value in Oza's
code to make error handling common.

We started by following the existing error handling scheme and then
moved onto the stop/remove behavior based on Bjorn's feedback.

The right thing is for Oza to rework the code to go back to original
error handling callback mechanism. That should be a trivial change.
