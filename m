Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1493148111.18659.5.camel@perches.com>
Subject: Re: [PATCH] PCI: imx6: fix spelling mistake: "contol" -> "control"
From: Joe Perches <joe@perches.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Colin King <colin.king@canonical.com>
Date: Tue, 25 Apr 2017 12:21:51 -0700
In-Reply-To: <20170425190429.GA29024@bhelgaas-glaptop.roam.corp.google.com>
References: <20170421070230.16582-1-colin.king@canonical.com>
 <20170425190429.GA29024@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-04-25 at 14:04 -0500, Bjorn Helgaas wrote:
> On Fri, Apr 21, 2017 at 08:02:30AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > trivial fix to spelling mistake in dev_err message
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Applied with Richard's ack to pci/host-imx6 for v4.12, thanks.
> 
> FWIW, there are about 25 other occurrences of "contol" in other parts
> of the tree.

Colin seems to focus on the logging format strings and
not code comments.

Other than these 2, there are 28 other instances in -next.
All of them are not output anywhere, these are just source
code comments.

$ git grep -w -i -E "contoller|contol" | wc -l
30

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
