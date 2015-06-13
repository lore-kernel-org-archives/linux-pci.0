Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 13 Jun 2015 11:32:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Julia Lawall <julia.lawall@lip6.fr>
cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [RFC v1 14/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <alpine.DEB.2.10.1506131059180.2486@hadrien>
Message-ID: <alpine.DEB.2.11.1506131130490.3786@nanos>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-15-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201724260.4225@nanos> <555CA834.7080807@linux.intel.com> <alpine.DEB.2.11.1505201750280.4225@nanos>
 <alpine.DEB.2.10.1506131059180.2486@hadrien>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 13 Jun 2015, Julia Lawall wrote:

> >     unsigned irq = irq_desc_get_irq(desc);
> 
> Actually, it seems that this function doesn't exist in linux-next either.
> What is the correct name of the function, or is there some other tree that
> I should be working on?

That's a new helper function, which is introduced in that series.

Thanks,

	tglx

---
 include/linux/irqdesc.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 8c84a2513665..a7aaef44a10e 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -100,6 +100,11 @@ static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
 #endif
 }
 
+static inline unsigned int irq_desc_get_irq(struct irq_desc *desc)
+{
+	return desc->irq_data.irq;
+}
+
 static inline struct irq_data *irq_desc_get_irq_data(struct irq_desc *desc)
 {
 	return &desc->irq_data;
-- 
1.7.10.4

