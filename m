Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V3 2/2] scsi: hpsa: drop shutdown callback
To: Don Brace <don.brace@microsemi.com>
References: <1527542471-10316-1-git-send-email-okaya@codeaurora.org>
 <1527542471-10316-2-git-send-email-okaya@codeaurora.org>
 <51bb7b82-c4a1-435c-7668-639db96d76e1@finnie.org>
 <af772e6434e645f4a42d22821442a3bd@microsemi.com>
 <3ebb873ea4658275e7fa89c01cd8bfe1@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <fe49b9b4-5e15-b0ae-59c3-33b5a31eeb9c@codeaurora.org>
Date: Fri, 1 Jun 2018 09:34:04 -0400
MIME-Version: 1.0
In-Reply-To: <3ebb873ea4658275e7fa89c01cd8bfe1@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Ryan Finnie <ryan@finnie.org>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "open list:HEWLETT-PACKARD SMART ARRAY RAID DRIVER \(hpsa\)"
 <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, "esc.storagedev" <esc.storagedev@microsemi.com>,
 open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 5/30/2018 9:08 PM, okaya@codeaurora.org wrote:
> I have seen that shutdown() is also called from remove().
> 
> remove() is supposed to do a safe cleanup too. If it is leaving the hw in inconsistent state even though it is c lling shutdown , it is yet another bug.

Let's try to be constructive. I'll post a patch with the pci_disable added to shutdown
only as in my original proposal.

Somebody can deal with remove another day.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
