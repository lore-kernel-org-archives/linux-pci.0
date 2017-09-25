Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 3/5] PCI: make pci_flr_wait() generic and rename to
 pci_dev_wait()
To: Christoph Hellwig <hch@infradead.org>
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
 <1506212218-29103-3-git-send-email-okaya@codeaurora.org>
 <20170924130806.GA12285@infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <e14953c9-f49a-0728-6a22-b705d7551f03@codeaurora.org>
Date: Sun, 24 Sep 2017 20:30:23 -0400
MIME-Version: 1.0
In-Reply-To: <20170924130806.GA12285@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 9/24/2017 9:08 AM, Christoph Hellwig wrote:
> On Sat, Sep 23, 2017 at 08:16:56PM -0400, Sinan Kaya wrote:
>> Rev 3.1 Sec 2.3.1 Request Handling Rules:
>> Valid reset conditions after which a device is permitted to return CRS
>> are:
>> * Cold, Warm, and Hot Resets,
>> * FLR
>> * A reset initiated in response to a D3hot to D0 uninitialized
>>
>> Try to reuse FLR implementation towards other reset types.
> 
> Maybe call it pci_reset_wait instead of pci_dev_wait?
> 

I can go for pci_dev_reset_wait(). I was using the PCI directory function
naming nomenclature where some functions using struct pci_dev start with
pci_dev and others using struct pci_bus start with pci_bus.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
