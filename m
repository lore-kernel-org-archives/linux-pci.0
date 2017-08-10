Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 10 Aug 2017 10:06:18 -0700
From: Tony Lindgren <tony@atomide.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] ARM: dts: DRA7: Add pcie1 dt node for EP mode
Message-ID: <20170810170617.GN8569@atomide.com>
References: <20170808054024.18507-1-kishon@ti.com>
MIME-Version: 1.0
In-Reply-To: <20170808054024.18507-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

* Kishon Vijay Abraham I <kishon@ti.com> [170807 22:41]:
> Add pcie1 dt node in order for the controller to operate in
> endpoint mode. However since none of the dra7 based boards have
> slots configured to operate in endpoint mode, keep EP mode
> disabled.

Applying into omap-for-v4.14/dt thanks.

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
