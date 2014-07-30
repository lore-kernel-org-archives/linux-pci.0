Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo03.seg.att.com ([209.65.160.84]:63244 "EHLO
	nbfkord-smmo03.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751223AbaG3KWO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 30 Jul 2014 06:22:14 -0400
Message-ID: <53D8C750.8010604@solarflare.com>
Date: Wed, 30 Jul 2014 11:22:08 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: pci_sriov_set_totalvfs question
References: <53D7A9FC.3040001@solarflare.com> <1406645502.1011.166.camel@ul30vt.home>
In-Reply-To: <1406645502.1011.166.camel@ul30vt.home>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29/07/14 15:51, Alex Williamson wrote:
> I believe this is referring to device_lock(), which should already be
> held on the PF during probe.  Thanks,
>
> Alex
>
I see, thanks for the help.
-Edward
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
