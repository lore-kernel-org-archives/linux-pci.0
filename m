Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 17/17] arm64: Do not expose PCI mmap through procfs
To: David Woodhouse <dwmw2@infradead.org>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1490188942.git.dwmw2@infradead.org>
 <4281f8e01b9fc5628cbf4a5c77abd642801e23c7.1490188942.git.dwmw2@infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <cd878fb7-86f1-50cc-d394-364cb8bde344@codeaurora.org>
Date: Wed, 22 Mar 2017 09:54:35 -0400
MIME-Version: 1.0
In-Reply-To: <4281f8e01b9fc5628cbf4a5c77abd642801e23c7.1490188942.git.dwmw2@infradead.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/22/2017 9:25 AM, David Woodhouse wrote:
>  
> +#ifdef __aarch64__
> +/* ARM64 wants to be special and not expose this through /proc like everyone else */
> +#undef HAVE_PCI_MMAP
> +#endif
> +

Where is this ARM64 special requirement coming from?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
