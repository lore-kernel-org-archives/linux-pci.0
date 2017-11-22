Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 22 Nov 2017 17:58:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH 29/30] i7300_idle: deprecate pci_get_bus_and_slot()
Message-ID: <20171122165829.GA2651@kroah.com>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-30-git-send-email-okaya@codeaurora.org>
 <20171122075345.GC26583@kroah.com>
 <81de37c1-26b5-41f7-ab32-b98012890971@codeaurora.org>
 <20171122164546.GB30812@kroah.com>
 <3cca8693-72bf-db72-f698-f111c9ef707c@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <3cca8693-72bf-db72-f698-f111c9ef707c@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, open list <linux-kernel@vger.kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 22, 2017 at 11:50:53AM -0500, Sinan Kaya wrote:
> On 11/22/2017 11:45 AM, Greg Kroah-Hartman wrote:
> >> Funny thing is nobody is calling this function. Maybe, I should just kill it
> >> instead.
> > Yes, delete it.  Why doesn't the build warn about it not being used?
> > 
> 
> OK. Because it is in a header file that nobody includes.

Even better, just delete the whole file!  :)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
