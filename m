Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 2 Jan 2018 14:44:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4 25/26] i7300_idle: remove unused file
Message-ID: <20180102134414.GA9603@kroah.com>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-26-git-send-email-okaya@codeaurora.org>
 <121cd93d-562c-8ebd-21df-1dafbc525c80@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <121cd93d-562c-8ebd-21df-1dafbc525c80@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, Philippe Ombredanne <pombredanne@nexb.com>,
 open list <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 02, 2018 at 08:36:46AM -0500, Sinan Kaya wrote:
> Hi Greg,
> 
> On 12/19/2017 12:38 AM, Sinan Kaya wrote:
> > i7300_idle.h is not being called by any source file and contains calls to
> > pci_get_bus_and_slot() that we are trying to deprecate. Remove unused file.
> > 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Do you think you can pick this up?

Sure, will do so, thanks.

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
