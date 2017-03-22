Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <4ccb4d92-3830-3980-38c3-7085a3d97734@codeaurora.org>
References: <1490196629-28088-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170322193111.GA8190@wunner.de>
 <31da6db5-be22-9e84-5e76-67c519bc0b34@codeaurora.org>
 <CAKv+Gu8Uw-X3AR6aQYevPdRfcgPNnqL4O3sRoKxsZAiW29sbqg@mail.gmail.com>
 <704b8b8c-e607-29b3-e101-bbecd90073bb@codeaurora.org>
 <CAKv+Gu-3wAXLyogLxg3N=6vf6Ryz2cLXw01tZUR_E48ddVU22A@mail.gmail.com>
 <4ccb4d92-3830-3980-38c3-7085a3d97734@codeaurora.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 22 Mar 2017 20:00:36 +0000
Message-ID: <CAKv+Gu9wORrhcYGLFdSubMrJiKwKzFBJkzS79Odc8sJRf6bJhA@mail.gmail.com>
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
 Matt Fleming <matt@codeblueprint.co.uk>, linux-pci <linux-pci@vger.kernel.org>,
 Peter Jones <pjones@redhat.com>, Heyi Guo <heyi.guo@linaro.org>,
 Lukas Wunner <lukas@wunner.de>, Hanjun Guo <hanjun.guo@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Yinghai Lu <yinghai@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 22 March 2017 at 19:57, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/22/2017 3:52 PM, Ard Biesheuvel wrote:
[..]
>> If you have working EFIFB on your platform, it works by accident. This
>> patch is needed to ensure that the BAR associated with the EFI
>> framebuffer is left untouched.
>>
>
> I never claimed that. I was just double checking your assumptions.
> I really don't like ARM64 specific PCI code in general. PCI doesn't care
> about CPU type. I hope to see this patch become part of common code.
>

Good! Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
