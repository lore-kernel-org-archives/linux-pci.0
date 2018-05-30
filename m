Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 30 May 2018 00:37:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI: Add pci=safemode option
Message-ID: <20180530073735.GA28793@infradead.org>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
 <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Ingo Molnar <mingo@kernel.org>,
 Christoffer Dall <cdall@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 timur@codeaurora.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Dongdong Liu <liudongdong3@huawei.com>, David Rientjes <rientjes@google.com>,
 Thymo van Beers <thymovanbeers@gmail.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Frederick Lawler <fred@fredlawl.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Oza Pawandeep <poza@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 29, 2018 at 09:41:33PM -0700, Sinan Kaya wrote:
> Bjorn and I discussed the need for such a "safe" mode feature when you
> want to bring up PCI for a platform. You want to turn off everything as
> a starter and just stick to bare minimum.

Can we please make it a config option the instead of adding code
to every kernel?  Also maybe the bringup should be in the name
to make this more clear?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
