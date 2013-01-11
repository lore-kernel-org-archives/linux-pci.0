Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:24043 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752427Ab3AKNxq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jan 2013 08:53:46 -0500
Message-ID: <50F01968.4030309@teksavvy.com>
Date: Fri, 11 Jan 2013 08:53:44 -0500
From: Mark Lord <kernel@teksavvy.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
CC: Robert Hancock <hancockrwd@gmail.com>, bl0 <bl0-052@playker.info>,
	linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_sil data corruption, possible workarounds
References: <kahap3$mur$1@ger.gmane.org> <50CCF1E0.9070804@gmail.com> <kakea2$dh1$1@ger.gmane.org> <50CEB13B.9010100@gmail.com> <kaq1n6$hqa$1@ger.gmane.org> <kb9pa2$mi8$1@ger.gmane.org> <50ECF6AB.30007@gmail.com> <20130109191753.GQ3926@htj.dyndns.org>
In-Reply-To: <20130109191753.GQ3926@htj.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13-01-09 02:17 PM, Tejun Heo wrote:
>
> Having a module option is easy and can be helpful for the very rare
> cases where the admin is aware of the issue, but, in general, it
> doesn't really help that much.

How about a sysfs attribute, rather than a boot option?

