Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1513689898.7000.191.camel@linux.intel.com>
Subject: Re: [PATCH V4 14/26] pch_gbe: deprecate pci_get_bus_and_slot()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org
Date: Tue, 19 Dec 2017 15:24:58 +0200
In-Reply-To: <ef7d09ce-06af-ad3e-1048-3b413cc32e9b@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-15-git-send-email-okaya@codeaurora.org>
 <1513680330.7000.167.camel@linux.intel.com>
 <ef7d09ce-06af-ad3e-1048-3b413cc32e9b@codeaurora.org>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kees Cook <keescook@chromium.org>, linux-arm-msm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 Tobias Klauser <tklauser@distanz.ch>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-12-19 at 07:17 -0500, Sinan Kaya wrote:
> On 12/19/2017 5:45 AM, Andy Shevchenko wrote:
> > On Tue, 2017-12-19 at 00:37 -0500, Sinan Kaya wrote:
> > > 

> > pci_get_bus_and_slot() still might be useful for the wired devices
> > in
> > SoC where we know for sure that domain == 0.
> > 
> 
> Then hard code the domain number as 0 while calling
> pci_get_domain_bus_and_slot()
> if you know for sure that this device will never work on a non-zero
> domain.

Thanks for so detailed explanation.

Okay, I suppose you did estimate the amount of drivers / modules that
may look better with pci_get_bus_and_slot() and the result is comparable
  small.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
