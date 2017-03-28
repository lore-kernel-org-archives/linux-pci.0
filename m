Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <466dcd2b-a781-2fe7-6ef0-5a3767c793e0@codeaurora.org>
References: <1490196629-28088-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170322193111.GA8190@wunner.de>
 <CAKv+Gu_X-SEnz7h9J8boqqjOQGHQawwdSAq4haH-OGu8zdfNfA@mail.gmail.com>
 <20170323084819.GA23281@h08.hostsharing.net>
 <CAKv+Gu93eJ-js3g7M6Jdm6XGMaWMswFmzBG2qNT4rn+3=1+EyA@mail.gmail.com>
 <20170323105727.GA2441@red-moon>
 <466dcd2b-a781-2fe7-6ef0-5a3767c793e0@codeaurora.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 28 Mar 2017 22:39:48 +0100
Message-ID: <CAKv+Gu9LbwpnJNi1OL25MWvYPxEOfKRHcs2jA2121BPaQWPzow@mail.gmail.com>
Subject: Re: [PATCH v3] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
To: Sinan Kaya <okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 Lukas Wunner <lukas@wunner.de>, Matt Fleming <matt@codeblueprint.co.uk>,
 linux-pci <linux-pci@vger.kernel.org>, Peter Jones <pjones@redhat.com>,
 Heyi Guo <heyi.guo@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Hanjun Guo <hanjun.guo@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Yinghai Lu <yinghai@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 28 March 2017 at 22:27, Sinan Kaya <okaya@codeaurora.org> wrote:
> Hi Lorenzo,
>
> On 3/23/2017 6:57 AM, Lorenzo Pieralisi wrote:
>>> Correct. But on x86 (or rather, on a PC), you can be sure that UEFI
>>> (or the legacy PCI bios) performed the resource assignment already.
>>> One could argue that this is equally the case when running arm64 in
>>> ACPI mode, but in general, you cannot assume the presence of firmware
>>> on ARM/arm64 that has already taken care of this, and so the state of
>>> the BARs has to be presumed invalid.
>> The story is a bit more convoluted than that owing to x86 (and other
>> arches) legacy.
>>
>> x86 tries to claim all PCI resources (in two passes - first enabled
>> devices, second disabled devices) and that predates ACPI/UEFI.
>>
>> Mind, x86 reassign resources that can't be claimed too, the only
>> difference with ARM64 is that, for the better or the worse, we
>> have decided not to claim the FW PCI set-up on ARM64 even if it
>> is sane, we do not even try, it was a deliberate choice.
>>
>> This patch should be harmless on x86 since if the FB PCI BAR is set
>> up sanely, claiming it again should be a nop (to be checked).
>>
>> For all the talk about PCI being arch agnostic as I said manifold
>> times before, that's just theory. In practice different arches
>> treat PCI FW set-up differently, it would be ideal to make them
>> uniform but legacy is huge and there is a massive risk of triggering
>> regressions, it is no mean feat (if achievable at all).
>
> Can we explore having a uniform behavior across ALL ACPI bases systems
> by trying to reuse the resources assigned by firmware first and reassign
> them only if something is wrong?
>
> There are protocols like hotplug reservation in UEFI. It looks like Linux
> is not honoring any of these protocols by being too smart.
>

Could you be more specific? Which protocol do you mean exactly, and
how does not reusing resources interfere with it?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
