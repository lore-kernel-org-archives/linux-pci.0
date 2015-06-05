Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1433513693.24429.55.camel@deneb.redhat.com>
Subject: Re: [RFT v2 23/48] c6x, irq: Prepare for killing the first
 parameter 'irq' of irq_flow_handler_t
From: Mark Salter <msalter@redhat.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Aurelien Jacquiot <a-jacquiot@ti.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-c6x-dev@linux-c6x.org
Date: Fri, 05 Jun 2015 10:14:53 -0400
In-Reply-To: <1433391238-19471-24-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
	 <1433391238-19471-24-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-06-04 at 12:13 +0800, Jiang Liu wrote:
> Change irq flow handler to prepare for killing the first parameter 'irq'
> of irq_flow_handler_t.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/c6x/platforms/megamod-pic.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Acked-by: Mark Salter <msalter@redhat.com>


