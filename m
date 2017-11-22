Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 30/30] PCI: remove pci_get_bus_and_slot() function
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-31-git-send-email-okaya@codeaurora.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <c0df99c9-9170-be3a-3789-6b25be30936f@codeaurora.org>
Date: Tue, 21 Nov 2017 23:45:37 -0600
MIME-Version: 1.0
In-Reply-To: <1511328675-21981-31-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 11/21/17 11:31 PM, Sinan Kaya wrote:
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.
> 
> Now that all users of pci_get_bus_and_slot() switched to
> pci_get_domain_bus_and_slot(), it is now safe to remove this function.

This doesn't really eliminate pci_get_bus_and_slot(), because it doesn't 
force developers to support non-zero domains.  What's to stop a driver 
developer from doing this?

#define pci_get_bus_and_slot(b, d) pci_get_domain_bus_and_slot(0, b, d)

thereby completely ignoring what you're trying to do?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
