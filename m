Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 13 Jan 2017 19:06:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 16/37] PCI: endpoint: Introduce configfs entry for
 configuring EP functions
Message-ID: <20170113180602.GA30346@infradead.org>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-17-git-send-email-kishon@ti.com>
MIME-Version: 1.0
In-Reply-To: <1484216786-17292-17-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
 Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
 nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

a couple comments on the configfs layout based on my experiments with
your previous drop to implement a NVMe device using it.

I don't think most of these configfs files should be present here, as
they are properties of the implemented PCIe devices.  E.g. for my
NVMe device they will be sort of hardcoded most of the time, as they
would be for other devices that would always have a fixed vendor/device/
class ID, cacheline size, etc.

In the end what we'll to be able to do here is to be able to create
a directory for each function driver, which then can create it's own
attributes inside it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
