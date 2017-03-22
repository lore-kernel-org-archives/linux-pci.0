Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v3] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
To: Lukas Wunner <lukas@wunner.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1490196629-28088-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170322193111.GA8190@wunner.de>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <31da6db5-be22-9e84-5e76-67c519bc0b34@codeaurora.org>
Date: Wed, 22 Mar 2017 15:36:49 -0400
MIME-Version: 1.0
In-Reply-To: <20170322193111.GA8190@wunner.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, matt@codeblueprint.co.uk,
 linux-pci@vger.kernel.org, pjones@redhat.com, heyi.guo@linaro.org,
 linux-efi@vger.kernel.org, hanjun.guo@linaro.org, bhelgaas@google.com,
 yinghai@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 3/22/2017 3:31 PM, Lukas Wunner wrote:
> On arm64 PCI systems, the entire PCI hierarchy is reconfigured from
> scratch at boot. This may result in the GOP framebuffer address to
> become stale, if the BAR covering the framebuffer is modified.

Does this code still work with the case where resources are not reassigned on ARM64?

As far as I know, kernel honors resource assignments done by the UEFI BIOS if
they are correct. Kernel will reassign the resources only if something is wrong.

Will this code break other platforms/architectures?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
