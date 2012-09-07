Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <504A78E9.4030005@lwfinger.net>
References: <504A78E9.4030005@lwfinger.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 7 Sep 2012 15:48:15 -0700
Message-ID: <CAErSpo7GEkN1XLZ=UeXmDZrLnp_648mH-sLYa9hMgOqz7t+b7Q@mail.gmail.com>
Subject: Re: Question about failure in PCI power-state change
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	=?GB2312?B?wO6zr8P3?= <chaoming_li@realsil.com.cn>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+cc Rafael, Huang, linux-pm

On Fri, Sep 7, 2012 at 3:44 PM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> Hi,
>
> On occasion when I unload and reload driver rtl8192ce, I get the message
>
> "Refused to change power state, currently in D3"
>
> I added additional info to the printk and discovered that it was trying to
> change to state D0. The problem seems to occur when I have made a
> connection, unloaded the driver, and reloaded it. If I do not make a
> connection before unloading, then the problem is a lot less likely.
>
> This is with kernel 3.6-rc4 from wireless-testing. A Google search shows
> that the problem is usually due to suspend/resume difficulties, but this
> machine has not been suspended.
>
> I would appreciate any help that you might give in solving this issue.
>
> Thanks,
>
> Larry
