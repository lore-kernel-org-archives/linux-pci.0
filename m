Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170322193111.GA8190@wunner.de>
References: <1490196629-28088-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170322193111.GA8190@wunner.de>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 22 Mar 2017 19:32:43 +0000
Message-ID: <CAKv+Gu_X-SEnz7h9J8boqqjOQGHQawwdSAq4haH-OGu8zdfNfA@mail.gmail.com>
Subject: Re: [PATCH v3] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
To: Lukas Wunner <lukas@wunner.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Matt Fleming <matt@codeblueprint.co.uk>, linux-pci <linux-pci@vger.kernel.org>,
 Peter Jones <pjones@redhat.com>, Heyi Guo <heyi.guo@linaro.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 Hanjun Guo <hanjun.guo@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Yinghai Lu <yinghai@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 22 March 2017 at 19:31, Lukas Wunner <lukas@wunner.de> wrote:
> On Wed, Mar 22, 2017 at 03:30:29PM +0000, Ard Biesheuvel wrote:
>> On UEFI systems, the PCI subsystem is enumerated by the firmware,
>> and if a graphical framebuffer is exposed by a PCI device, its base
>> address and size are exposed to the OS via the Graphics Output
>> Protocol (GOP).
>>
>> On arm64 PCI systems, the entire PCI hierarchy is reconfigured from
>> scratch at boot. This may result in the GOP framebuffer address to
>> become stale, if the BAR covering the framebuffer is modified. This
>> will cause the framebuffer to become unresponsive, and may in some
>> cases result in unpredictable behavior if the range is reassigned to
>> another device.
>
> Hm, commit message seems to indicate the issue is restricted to arm64,
> yet there's no IS_ENABLED(ARM64) to constrain the added code to that arch?
>

True. I am eager to get some x86 coverage for this, since I would
expect this not to do any harm. But I'm fine with making it ARM/arm64
specific in the final version.

>
>> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, efifb_fixup_resources);
>
> Maybe this can be constrained to PCI_BASE_CLASS_DISPLAY?
>

How does one do that with DECLARE_PCI_FIXUP_HEADER?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
