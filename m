Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4281f8e01b9fc5628cbf4a5c77abd642801e23c7.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org> <4281f8e01b9fc5628cbf4a5c77abd642801e23c7.1490188942.git.dwmw2@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 24 Mar 2017 17:13:36 +0100
Message-ID: <CAK8P3a3RtSCGfbtpJDF2d30rLagPMY=HnnjYpBe+k1UxKrXOig@mail.gmail.com>
Subject: Re: [PATCH 17/17] arm64: Do not expose PCI mmap through procfs
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 22, 2017 at 2:25 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  drivers/pci/proc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 2d9cfa4..a940f4b 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -17,6 +17,11 @@
>
>  static int proc_initialized;   /* = 0 */
>
> +#ifdef __aarch64__
> +/* ARM64 wants to be special and not expose this through /proc like everyone else */
> +#undef HAVE_PCI_MMAP
> +#endif

I'd still prefer this to be a whitelist of the existing architectures using PCI
MMAP in procfs, there is really no reason for arm64 to be special, the
one thing we want to control here is whether new architectures (including
arm64) that have never had either the sysfs or the procfs interface
should get one or both of them.

As it seems that there are important use cases for the sysfs interface
and your patch series will just make that work everywhere, I'd argue
that we should just always provide the sysfs interface now, and use
HAVE_PCI_MMAP only control the procfs interface.

That way, we turn on the sysfs interface on arc, arm64, frv and tile
as well as any future architecture with PCI support, but leave
the procfs support as opt-in.

       Arnd
