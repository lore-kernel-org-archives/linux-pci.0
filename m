Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V3 2/2] PCI: handle CRS returned by device after FLR
To: Alex Williamson <alex.williamson@redhat.com>
References: <1475473021-14251-1-git-send-email-okaya@codeaurora.org>
 <1475473021-14251-3-git-send-email-okaya@codeaurora.org>
 <ac667a77-028d-d5da-f574-61f787fec72c@codeaurora.org>
 <20170221135138.791ba4e2@t450s.home>
 <fa4f3b57-dccc-c64a-0787-1ecd3687534f@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <76938ac9-d898-1aa5-530c-d106584202d5@codeaurora.org>
Date: Wed, 1 Mar 2017 12:31:49 -0500
MIME-Version: 1.0
In-Reply-To: <fa4f3b57-dccc-c64a-0787-1ecd3687534f@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo.Pieralisi@arm.com, vikrams@codeaurora.org,
 linux-pci@vger.kernel.org, timur@codeaurora.org, linux-kernel@vger.kernel.org,
 cov@codeaurora.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2/21/2017 9:37 PM, Sinan Kaya wrote:
>> SR-IOV spec rev 1.1, 3.4.1.1 & 3.4.1.2, Vendor ID and Device ID fields
>> for the VF return 0xFFFF when read.  The "Virtualization Intermediary"
>> is supposed to use the vendor ID from the PF and the device ID defined
>> in the PF SR-IOV capability.
> 
> Interesting. Since lspci was showing the correct vendor id and device id, I
> assumed that it is coming from offset 0.
> 
> Maybe, the right thing is to figure out if this is a virtual function or not.
> If it is a physical function, check the CRS first before reading the command
> register in the existing loop.
> 
> 

I went back and read the spec for CRS in FLR case one more time. We are required
to wait up to 1 seconds if the device is sending CRS. The current code seems to
be already handling this delay. 



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
