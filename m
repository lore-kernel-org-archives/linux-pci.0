Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V2 3/7] PCI: make pci_flr_wait() generic and rename to
 pci_dev_wait()
To: Christoph Hellwig <hch@infradead.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
 <1511763628-11856-4-git-send-email-okaya@codeaurora.org>
 <20171129173801.GD27742@infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0248af7b-0459-2b77-e439-bfcdfebcd7f6@codeaurora.org>
Date: Mon, 4 Dec 2017 08:17:20 -0500
MIME-Version: 1.0
In-Reply-To: <20171129173801.GD27742@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Linux PCI <linux-pci@vger.kernel.org>, timur@codeaurora.org,
 open list <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 11/29/2017 12:38 PM, Christoph Hellwig wrote:
> On Mon, Nov 27, 2017 at 01:20:24AM -0500, Sinan Kaya wrote:
>> Rev 3.1 Sec 2.3.1 Request Handling Rules:
>> Valid reset conditions after which a device is permitted to return CRS
>> are:
>> * Cold, Warm, and Hot Resets,
>> * FLR
>> * A reset initiated in response to a D3hot to D0 uninitialized
>>
>> Try to reuse FLR implementation towards other reset types.
> 
> Should we keep a helper for the FLR wait?  If not I guess the reference
> for AF_FLR should be the PCI spec, not the PCIE spec.
> 

Bjorn,

what is your opinion?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
