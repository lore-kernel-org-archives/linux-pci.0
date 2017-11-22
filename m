Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1511353247.3539.10.camel@linux.intel.com>
Subject: Re: [PATCH 23/30] [media] atomisp: deprecate pci_get_bus_and_slot()
From: Alan Cox <alan@linux.intel.com>
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org
Date: Wed, 22 Nov 2017 12:20:47 +0000
In-Reply-To: <1511328675-21981-24-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-24-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 kbuild test robot <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Valentin Vidic <Valentin.Vidic@CARNet.hr>, linux-arm-msm@vger.kernel.org,
 Philippe Ombredanne <pombredanne@nexb.com>,
 open list <linux-kernel@vger.kernel.org>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Avraham Shukron <avraham.shukron@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:STAGING
 SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, "open list:MEDIA INPUT
 INFRASTRUCTURE \(V4L/DVB\)" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-11-22 at 00:31 -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0
> as
> where a PCI device is present. This restricts the device drivers to
> be
> reused for other domain numbers.

The ISP v2 will always been in domain 0.

Alan


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
