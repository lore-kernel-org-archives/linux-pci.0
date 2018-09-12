Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 12 Sep 2018 20:13:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 05/17] compat_ioctl: move more drivers to
 generic_compat_ioctl_ptrarg
Message-ID: <20180912181330.GC15031@kroah.com>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151134.436719-1-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20180912151134.436719-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-nvme@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 sparclinux@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-scsi@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-rdma@vger.kernel.org, qat-linux@intel.com, amd-gfx@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 ceph-devel@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-btrfs@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 12, 2018 at 05:08:52PM +0200, Arnd Bergmann wrote:
> The .ioctl and .compat_ioctl file operations have the same prototype so
> they can both point to the same function, which works great almost all
> the time when all the commands are compatible.
> 
> One exception is the s390 architecture, where a compat pointer is only
> 31 bit wide, and converting it into a 64-bit pointer requires calling
> compat_ptr(). Most drivers here will ever run in s390, but since we now
> have a generic helper for it, it's easy enough to use it consistently.
> 
> I double-checked all these drivers to ensure that all ioctl arguments
> are used as pointers or are ignored, but are not interpreted as integer
> values.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
