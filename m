Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V4] PCI: Add Extended Tags quirk for Broadcom HT2100 Root
 Port
To: Ethan Zhao <ethan.kernel@gmail.com>, Wim ten Have <wim.ten.have@oracle.com>
References: <1499832255-9845-1-git-send-email-okaya@codeaurora.org>
 <20170712105550.6007fa06.wim.ten.have@oracle.com>
 <CABawtvMCJy1Y0Cv-NhVRv4qKLiZ-PUWfeZhTA6uGiiiswe+g6A@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <b8ccaffe-d907-db04-a793-86a3b67f61af@codeaurora.org>
Date: Wed, 12 Jul 2017 08:15:43 -0400
MIME-Version: 1.0
In-Reply-To: <CABawtvMCJy1Y0Cv-NhVRv4qKLiZ-PUWfeZhTA6uGiiiswe+g6A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci <linux-pci@vger.kernel.org>, timur@codeaurora.org,
 LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 7/12/2017 5:44 AM, Ethan Zhao wrote:
> The dmesg yelled "...Tag handling is broken" , but didn't say how it
> was handled, that is weird and confusing, just because there is no
> device under that bridge ?
> 
> How about move the messages together "...is broken, disable Extended tag..."

This was something requested by Bjorn to inform that user has a broken HW
when a quirk is matched.

The new code will disable extended tags only if it was enabled on endpoint
via power on reset value or via some broken BIOS.

It looks like we are not seeing any disabling message. This implies that
both the card and BIOS is good.

That's why, you are no longer seeing a disabling message on this system
and code is just not enabling extended tags.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
