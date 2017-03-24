Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3RtSCGfbtpJDF2d30rLagPMY=HnnjYpBe+k1UxKrXOig@mail.gmail.com>
References: <cover.1490188942.git.dwmw2@infradead.org> <4281f8e01b9fc5628cbf4a5c77abd642801e23c7.1490188942.git.dwmw2@infradead.org>
 <CAK8P3a3RtSCGfbtpJDF2d30rLagPMY=HnnjYpBe+k1UxKrXOig@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 24 Mar 2017 17:16:43 +0100
Message-ID: <CAK8P3a0+os4sNzmPYvm-MrsdppZEg9VKhQ9ROJf9DumXCHgnhA@mail.gmail.com>
Subject: Re: [PATCH 17/17] arm64: Do not expose PCI mmap through procfs
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 24, 2017 at 5:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Mar 22, 2017 at 2:25 PM, David Woodhouse <dwmw2@infradead.org> wrote:
>> From: David Woodhouse <dwmw@amazon.co.uk>
>>
>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>> ---
>>  drivers/pci/proc.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
>> index 2d9cfa4..a940f4b 100644
>> --- a/drivers/pci/proc.c
>> +++ b/drivers/pci/proc.c
>> @@ -17,6 +17,11 @@
>>
>>  static int proc_initialized;   /* = 0 */
>>
>> +#ifdef __aarch64__
>> +/* ARM64 wants to be special and not expose this through /proc like everyone else */
>> +#undef HAVE_PCI_MMAP
>> +#endif
>
> I'd still prefer this to be a whitelist of the existing architectures using PCI
> MMAP in procfs, there is really no reason for arm64 to be special, the
> one thing we want to control here is whether new architectures (including
> arm64) that have never had either the sysfs or the procfs interface
> should get one or both of them.
>
> As it seems that there are important use cases for the sysfs interface
> and your patch series will just make that work everywhere, I'd argue
> that we should just always provide the sysfs interface now, and use
> HAVE_PCI_MMAP only control the procfs interface.
>
> That way, we turn on the sysfs interface on arc, arm64, frv and tile
> as well as any future architecture with PCI support, but leave
> the procfs support as opt-in.

Something alone these lines, to replace your patch 17/17 and the
one that turns on HAVE_PCI_MMAP for arm64.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 25d010d449a3..c517f1b724e0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -980,8 +980,6 @@ void pci_remove_legacy_files(struct pci_bus *b)
 }
 #endif /* HAVE_PCI_LEGACY */

-#ifdef HAVE_PCI_MMAP
-
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
   enum pci_mmap_api mmap_api)
 {
@@ -1217,10 +1215,6 @@ static int pci_create_resource_files(struct
pci_dev *pdev)
  }
  return 0;
 }
-#else /* !HAVE_PCI_MMAP */
-int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
-void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
-#endif /* HAVE_PCI_MMAP */

 /**
  * pci_write_rom - used to enable access to the PCI ROM display
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8dd38e69d6f2..6c2a15d4ebf9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -21,14 +21,12 @@ void pci_create_firmware_label_files(struct pci_dev *pdev);
 void pci_remove_firmware_label_files(struct pci_dev *pdev);
 #endif
 void pci_cleanup_rom(struct pci_dev *dev);
-#ifdef HAVE_PCI_MMAP
 enum pci_mmap_api {
  PCI_MMAP_SYSFS, /* mmap on /sys/bus/pci/devices/<BDF>/resource<N> */
  PCI_MMAP_PROCFS /* mmap on /proc/bus/pci/<BDF> */
 };
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
   enum pci_mmap_api mmap_api);
-#endif
 int pci_probe_reset_function(struct pci_dev *dev);

 /**
