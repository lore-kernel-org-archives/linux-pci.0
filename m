Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: Do not enable extended tags on pre-dated (v1.x)
 systems
To: Jike Song <albcamus@gmail.com>
References: <1499260748-21860-1-git-send-email-okaya@codeaurora.org>
 <CANE52Ki_B0pitpyNMBjrtEJBX6Cspe8-m3hZuEFCWuBN2osh-g@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <c5e37c83-a43d-257a-fa2f-50fdab29ce7a@codeaurora.org>
Date: Fri, 7 Jul 2017 09:31:09 -0400
MIME-Version: 1.0
In-Reply-To: <CANE52Ki_B0pitpyNMBjrtEJBX6Cspe8-m3hZuEFCWuBN2osh-g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 wim.ten.have@oracle.com, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 7/7/2017 1:04 AM, Jike Song wrote:
> Maybe checking the version of this endpoint at first? Do you expect a
> v1 endpoint
> to be working under v2+ ports?

I see your point. I guess we need to validate both incoming and outgoing.
I was only checking incoming direction. 

Let me look at this one more time.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
