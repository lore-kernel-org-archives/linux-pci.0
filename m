Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 19 Jun 2018 16:59:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
Message-ID: <20180619215955.GF33049@bhelgaas-glaptop.roam.corp.google.com>
References: <1526563343-28721-1-git-send-email-okaya@codeaurora.org>
 <36cf3f12-bfe8-1c38-4d2c-b785fc64a3f6@arm.com>
 <733101d0-9051-a5a6-ef64-162d8d1e10a1@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <733101d0-9051-a5a6-ef64-162d8d1e10a1@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-pci@vger.kernel.org, timur@codeaurora.org, ard.biesheuvel@linaro.org,
 open list <linux-kernel@vger.kernel.org>,
 "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
 Peter Jones <pjones@redhat.com>, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2018 at 10:20:29AM -0400, Sinan Kaya wrote:
> On 5/18/2018 6:42 AM, Robin Murphy wrote:
> > 
> > FWIW, now that I've actually gone and looked, it appears you could simplify the whole function quite a bit by getting rid of these and just using the new local resource directly, especially since the only actual use of size is an open-coded resource_contains().
> 
> Posted V2 a minute ago. I did the simplification on a prior patch in order not to
> mix the issues.

I don't see the V2 on linux-pci, but it sounds like Ard would merge this
anyway.  So I'll drop this and you can let me know if there's anything you
need from me.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
