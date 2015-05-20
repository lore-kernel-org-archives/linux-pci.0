Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 May 2015 11:44:36 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [RFC v1 08/25] mfd: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
Message-ID: <20150520104436.GF3627@x1>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
 <1432116013-25902-9-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1432116013-25902-9-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 20 May 2015, Jiang Liu wrote:

> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
> 
> Do the same thing to avoid pattern "irq_get_chip_data(data->irq)".
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/mfd/ezx-pcap.c    |    2 +-
>  drivers/mfd/max8997-irq.c |    8 ++++----
>  drivers/mfd/mt6397-core.c |    8 ++++----
>  drivers/mfd/t7l66xb.c     |    2 +-
>  drivers/mfd/tc6393xb.c    |    2 +-
>  drivers/mfd/twl6030-irq.c |    2 +-
>  6 files changed, 12 insertions(+), 12 deletions(-)

Again, so long as this has been properly tested:

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
> index 5991faddd3c6..e5f4ffaa5414 100644
> --- a/drivers/mfd/ezx-pcap.c
> +++ b/drivers/mfd/ezx-pcap.c
> @@ -207,7 +207,7 @@ static void pcap_isr_work(struct work_struct *work)
>  
>  static void pcap_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
> -	struct pcap_chip *pcap = irq_get_handler_data(irq);
> +	struct pcap_chip *pcap = irq_desc_get_handler_data(desc);
>  
>  	desc->irq_data.chip->irq_ack(&desc->irq_data);
>  	queue_work(pcap->workqueue, &pcap->isr_work);
> diff --git a/drivers/mfd/max8997-irq.c b/drivers/mfd/max8997-irq.c
> index 43fa61413e93..381738b477f8 100644
> --- a/drivers/mfd/max8997-irq.c
> +++ b/drivers/mfd/max8997-irq.c
> @@ -113,14 +113,14 @@ static const struct max8997_irq_data max8997_irqs[] = {
>  
>  static void max8997_irq_lock(struct irq_data *data)
>  {
> -	struct max8997_dev *max8997 = irq_get_chip_data(data->irq);
> +	struct max8997_dev *max8997 = irq_data_get_irq_chip_data(data);
>  
>  	mutex_lock(&max8997->irqlock);
>  }
>  
>  static void max8997_irq_sync_unlock(struct irq_data *data)
>  {
> -	struct max8997_dev *max8997 = irq_get_chip_data(data->irq);
> +	struct max8997_dev *max8997 = irq_data_get_irq_chip_data(data);
>  	int i;
>  
>  	for (i = 0; i < MAX8997_IRQ_GROUP_NR; i++) {
> @@ -148,7 +148,7 @@ irq_to_max8997_irq(struct max8997_dev *max8997, int irq)
>  
>  static void max8997_irq_mask(struct irq_data *data)
>  {
> -	struct max8997_dev *max8997 = irq_get_chip_data(data->irq);
> +	struct max8997_dev *max8997 = irq_data_get_irq_chip_data(data);
>  	const struct max8997_irq_data *irq_data = irq_to_max8997_irq(max8997,
>  								data->irq);
>  
> @@ -157,7 +157,7 @@ static void max8997_irq_mask(struct irq_data *data)
>  
>  static void max8997_irq_unmask(struct irq_data *data)
>  {
> -	struct max8997_dev *max8997 = irq_get_chip_data(data->irq);
> +	struct max8997_dev *max8997 = irq_data_get_irq_chip_data(data);
>  	const struct max8997_irq_data *irq_data = irq_to_max8997_irq(max8997,
>  								data->irq);
>  
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 09bc7804952a..dab325b9d0df 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -39,14 +39,14 @@ static const struct mfd_cell mt6397_devs[] = {
>  
>  static void mt6397_irq_lock(struct irq_data *data)
>  {
> -	struct mt6397_chip *mt6397 = irq_get_chip_data(data->irq);
> +	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
>  
>  	mutex_lock(&mt6397->irqlock);
>  }
>  
>  static void mt6397_irq_sync_unlock(struct irq_data *data)
>  {
> -	struct mt6397_chip *mt6397 = irq_get_chip_data(data->irq);
> +	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
>  
>  	regmap_write(mt6397->regmap, MT6397_INT_CON0, mt6397->irq_masks_cur[0]);
>  	regmap_write(mt6397->regmap, MT6397_INT_CON1, mt6397->irq_masks_cur[1]);
> @@ -56,7 +56,7 @@ static void mt6397_irq_sync_unlock(struct irq_data *data)
>  
>  static void mt6397_irq_disable(struct irq_data *data)
>  {
> -	struct mt6397_chip *mt6397 = irq_get_chip_data(data->irq);
> +	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
>  	int shift = data->hwirq & 0xf;
>  	int reg = data->hwirq >> 4;
>  
> @@ -65,7 +65,7 @@ static void mt6397_irq_disable(struct irq_data *data)
>  
>  static void mt6397_irq_enable(struct irq_data *data)
>  {
> -	struct mt6397_chip *mt6397 = irq_get_chip_data(data->irq);
> +	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
>  	int shift = data->hwirq & 0xf;
>  	int reg = data->hwirq >> 4;
>  
> diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
> index c09fb5dccd50..b752ca2be549 100644
> --- a/drivers/mfd/t7l66xb.c
> +++ b/drivers/mfd/t7l66xb.c
> @@ -187,7 +187,7 @@ static struct mfd_cell t7l66xb_cells[] = {
>  /* Handle the T7L66XB interrupt mux */
>  static void t7l66xb_irq(unsigned int irq, struct irq_desc *desc)
>  {
> -	struct t7l66xb *t7l66xb = irq_get_handler_data(irq);
> +	struct t7l66xb *t7l66xb = irq_desc_get_handler_data(desc);
>  	unsigned int isr;
>  	unsigned int i, irq_base;
>  
> diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
> index 63458b39a97d..d21253a51cff 100644
> --- a/drivers/mfd/tc6393xb.c
> +++ b/drivers/mfd/tc6393xb.c
> @@ -525,7 +525,7 @@ static int tc6393xb_register_gpio(struct tc6393xb *tc6393xb, int gpio_base)
>  static void
>  tc6393xb_irq(unsigned int irq, struct irq_desc *desc)
>  {
> -	struct tc6393xb *tc6393xb = irq_get_handler_data(irq);
> +	struct tc6393xb *tc6393xb = irq_desc_get_handler_data(desc);
>  	unsigned int isr;
>  	unsigned int i, irq_base;
>  
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> index 2807e1a95663..5b8cd5cd42cf 100644
> --- a/drivers/mfd/twl6030-irq.c
> +++ b/drivers/mfd/twl6030-irq.c
> @@ -231,7 +231,7 @@ static irqreturn_t twl6030_irq_thread(int irq, void *data)
>  
>  static int twl6030_irq_set_wake(struct irq_data *d, unsigned int on)
>  {
> -	struct twl6030_irq *pdata = irq_get_chip_data(d->irq);
> +	struct twl6030_irq *pdata = irq_data_get_irq_chip_data(d);
>  
>  	if (on)
>  		atomic_inc(&pdata->wakeirqs);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
