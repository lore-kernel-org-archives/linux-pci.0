Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 19 Dec 2017 09:53:36 -0500 (EST)
Message-Id: <20171219.095336.2222430428460536576.davem@davemloft.net>
To: okaya@codeaurora.org
Subject: Re: [PATCH V4 14/26] pch_gbe: deprecate pci_get_bus_and_slot()
From: David Miller <davem@davemloft.net>
In-Reply-To: <ef7d09ce-06af-ad3e-1048-3b413cc32e9b@codeaurora.org>
References: <1513661883-28662-15-git-send-email-okaya@codeaurora.org>
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
Cc: keescook@chromium.org, linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, tklauser@distanz.ch,
 andriy.shevchenko@linux.intel.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Sinan Kaya <okaya@codeaurora.org>
Date: Tue, 19 Dec 2017 07:17:41 -0500

> Then hard code the domain number as 0 while calling
> pci_get_domain_bus_and_slot() if you know for sure that this device
> will never work on a non-zero domain.

Agreed, it's so much better to be explicit about this.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
