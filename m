Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4F50ABD1.7000402@mvista.com>
References: <1330629843-6027-1-git-send-email-yinghai@kernel.org>
	<4F50ABD1.7000402@mvista.com>
Date: Fri, 2 Mar 2012 08:34:55 -0800
Message-ID: <CAE9FiQUPY_-GKt9KCUPPr-qarqDKL-VQ2ZdXs8OR1Fv68JFAEg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] usb, PCI: split quirk for usb host controller to four
From: Yinghai Lu <yinghai@kernel.org>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 2, 2012 at 3:15 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
>
> On 01-03-2012 23:24, Yinghai Lu wrote:
>
>> so we avoid checking class again and again in that quirk.
>
>
>> following patches will remove disable/enable for non-xhci
>> and nelogic vendor checking for uhci/xhci
>
>
>   Why add them in the first place?
>

never mind, just drop those patches, sarah had some different view and
want to keep disable/enable
device for all usb host controller instead of only xhci.

Thanks

       Yinghai
