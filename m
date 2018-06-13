Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 13 Jun 2018 22:51:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, peterz@infradead.org,
        tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net,
        lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, zhangpanyong@hygon.cn,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-x86_64@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 00/11] Add support for Hygon's Dhyana Family 18h processor
Message-ID: <20180613205129.GD26375@zn.tnic>
References: <1528550410-28080-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1528550410-28080-1-git-send-email-puwen@hygon.cn>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 09, 2018 at 09:20:10PM +0800, Pu Wen wrote:
> As a new x86 CPU Vendor, Chengdu Haiguang IC Design Co., Ltd (Hygon)
> is a Joint Venture between AMD and Haiguang Information Technology Co.,
> Ltd., and aims at providing high performance x86 processor for China
> server market.
> 
> The first generation Hygon's processor(Dhyana) originates from AMD
> technology and shares most of the architecture with AMD's family 17h,
> but with different CPU Vendor ID("HygonGenuine")/PCIE Device Vendor ID
> (0x1D94)/Family series number(Family 18h).
> 
> To enable the support of Linux kernel to Hygon's CPU, we added a new
> vendor type (X86_VENDOR_HYGON, with value of 9) in arch/x86/include/
> asm/processor.h, and shared most of kernel support codes with AMD
> family 17h.
> 
> These patches have been applied and tested successfully in Hygon's
> Dhyana SoC silicon. Also tested on AMD's EPYC (Family 17h) processor
> works fine and makes no harm to existing codes.

Well, I don't like this diffstat:

 37 files changed, 183 insertions(+), 56 deletions(-)

which adds a lot of code checking this new vendor. But then it adds in
the AMD paths and I don't see it being any different from an AMD CPU. So
it does the same a Zen does but then it is Hygon.

So I'd prefer to *not* sprinkle those X86_VENDOR_HYGON checks everywhere
but simply have the vendor be X86_VENDOR_AMD and only the user-visible
reporting to show that it is Hygon. Because to the kernel it is an AMD
CPU - only the superficial attributes are something else. Oh well, and
PCI device IDs but that's like another CPU revision.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
