Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <51C3D517.1080301@st.com>
Date: Fri, 21 Jun 2013 09:52:47 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Andrew Murray' <andrew.murray@arm.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	'Tomasz Figa' <t.figa@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>
Subject: Re: [PATCH V9 1/4] pci: Add PCIe driver for Samsung Exynos
References: <002001ce6e2e$623d7970$26b86c50$@samsung.com>
In-Reply-To: <002001ce6e2e$623d7970$26b86c50$@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/21/2013 8:51 AM, Jingoo Han wrote:
> diff --git a/drivers/pci/host/pci-designware.c b/drivers/pci/host/pci-designware.c
> new file mode 100644
> index 0000000..f8558ff
> --- /dev/null
> +++ b/drivers/pci/host/pci-designware.c

If you plan to send next version, then I would suggest to rename it as 
pcie-designware.c, because synopsis pcie and pci controllers are different.

Regards
Pratyush




