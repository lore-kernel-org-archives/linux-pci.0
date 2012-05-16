Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37464 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967532Ab2EPNxc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 May 2012 09:53:32 -0400
Message-ID: <4FB3B159.2090401@ladisch.de>
Date: Wed, 16 May 2012 15:53:29 +0200
From: Clemens Ladisch <clemens@ladisch.de>
MIME-Version: 1.0
To: Rob Allen <ra-kernel@hotmail.co.uk>
CC: Yinghai Lu <yinghai@kernel.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Ram Pai <linuxram@us.ibm.com>,
	linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
References: <bug-43244-4803@https.bugzilla.kernel.org/> <20120513221357.7574ae79@stein> <4FB0A6F6.9050504@ladisch.de> <CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com> <BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl>
In-Reply-To: <BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl>
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rob Allen wrote:
> On 14/05/12 07:39, Yinghai Lu wrote:
>> can you post full log with pci debug enabled with lastest upsteam kernel?
>
> I'm happy to do that, although I need with some guidance on what I need to
> enable to get the required output.

For Ubuntu, see <https://wiki.ubuntu.com/KernelTeam/GitKernelBuild>.

To enable PCI debugging, enable the configuration options
CONFIG_DEBUG_KERNEL and CONFIG_PCI_DEBUG.


Regards,
Clemens
