Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 25 Apr 2018 17:27:45 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 1/6] PCI: Make pci_get_new_domain_nr static
Message-ID: <20180425162745.GB21628@e107981-ln.cambridge.arm.com>
References: <cover.1524582822.git.jan.kiszka@siemens.com>
 <a21882288c4664cc983a5741e8cbf6d59abacd46.1524582822.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
In-Reply-To: <a21882288c4664cc983a5741e8cbf6d59abacd46.1524582822.git.jan.kiszka@siemens.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 24, 2018 at 05:13:37PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The only user of that function is of_pci_bus_find_domain_nr. Pure
> cleanup.

"The only user of pci_get_new_domain_nr() is of_pci_bus_find_domain_nr().
Since they are defined in the same compilation unit,
pci_get_new_domain_nr() can be made static, which also simplifies
preprocessor conditionals.

No functional change intended."

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/pci/pci.c   | 6 ++----
>  include/linux/pci.h | 3 ---
>  2 files changed, 2 insertions(+), 7 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e597655a5643..695c2bb4e853 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5702,15 +5702,14 @@ static void pci_no_domains(void)
>  #endif
>  }
>  
> -#ifdef CONFIG_PCI_DOMAINS
> +#ifdef CONFIG_PCI_DOMAINS_GENERIC
>  static atomic_t __domain_nr = ATOMIC_INIT(-1);
>  
> -int pci_get_new_domain_nr(void)
> +static int pci_get_new_domain_nr(void)
>  {
>  	return atomic_inc_return(&__domain_nr);
>  }
>  
> -#ifdef CONFIG_PCI_DOMAINS_GENERIC
>  static int of_pci_bus_find_domain_nr(struct device *parent)
>  {
>  	static int use_dt_domains = -1;
> @@ -5765,7 +5764,6 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
>  			       acpi_pci_bus_find_domain_nr(bus);
>  }
>  #endif
> -#endif
>  
>  /**
>   * pci_ext_cfg_avail - can we access extended PCI config space?
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 73178a2fcee0..963232a6cd2e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1510,12 +1510,10 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
>   */
>  #ifdef CONFIG_PCI_DOMAINS
>  extern int pci_domains_supported;
> -int pci_get_new_domain_nr(void);
>  #else
>  enum { pci_domains_supported = 0 };
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>  static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
> -static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>  #endif /* CONFIG_PCI_DOMAINS */
>  
>  /*
> @@ -1670,7 +1668,6 @@ static inline struct pci_dev *pci_get_domain_bus_and_slot(int domain,
>  
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>  static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
> -static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>  
>  #define dev_is_pci(d) (false)
>  #define dev_is_pf(d) (false)
> -- 
> 2.13.6
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
