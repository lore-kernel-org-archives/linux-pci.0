Return-Path: <jonathan.yong@intel.com>
Return-Path: <jonathan.yong@intel.com>
Message-ID: <578EBC81.3090601@intel.com>
Date: Wed, 20 Jul 2016 07:49:21 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] PCI: Precision Time Measurement support
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20160719211926.GB17840@localhost>
In-Reply-To: <20160719211926.GB17840@localhost>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pci.vger.kernel.org>

On 07/20/2016 05:19, Bjorn Helgaas wrote:
> On Mon, Jun 13, 2016 at 02:05:26PM -0500, Bjorn Helgaas wrote:
>> This is a slightly different proposal for the PTM support Jonathan
>> proposed here:
>>
>>   http://lkml.kernel.org/r/1462956446-27361-2-git-send-email-jonathan.yong@intel.com
>>
>> I split this into three pieces mostly for ease in reviewing.  They
>> could all be squashed:
>>
>>   - Enable PTM in root ports and switches automatically at boot
>>   - Enable PTM in endpoints when requested by driver
>>   - Add clock granularity information
>>
>> I have some open questions about how PTM works on Root Complex
>> Integrated Endpoints and whether we should enable it automatically
>> even without a driver request.  And I probably left out some details
>> of the clock granularity computation, so treat this as more of an RFC
>> than anything.
>>
> 
> Jonathan, any comments?
> 

I don't have any new information on how to configure integrated endpoints.

This line:
ctrl = PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT;

should also set the responder capable bit (7.32.2):
	If PTM Root Capable is Set, this bit must be Set to 1b.
