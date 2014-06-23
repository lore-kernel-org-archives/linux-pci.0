Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:35516 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaFWMAF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jun 2014 08:00:05 -0400
MIME-Version: 1.0
In-Reply-To: <CANwwZzWsjQwZB5Cc4Hyv2HQOLhAx6ycjf32UQG55zVX=Kmbi6Q@mail.gmail.com>
References: <CANwwZzWsjQwZB5Cc4Hyv2HQOLhAx6ycjf32UQG55zVX=Kmbi6Q@mail.gmail.com>
Date: Mon, 23 Jun 2014 15:00:04 +0300
Message-ID: <CAJZOPZ+FUneDDKMh0O2aZLYeDTcH8cHA7ati5wzi7Ycgc5wFXQ@mail.gmail.com>
Subject: Re: mlx4 - query regarding PF VF functionality division
From: Or Gerlitz <or.gerlitz@gmail.com>
To: Bob Biloxi <iambobbiloxi@gmail.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 23, 2014 at 12:33 PM, Bob Biloxi <iambobbiloxi@gmail.com> wrote:
[...]
> Is there any way we can clearly separate the files that are used by PF
> vs the files that are used by VF in the (drivers/net/ethernet/mlx4
> sub-directory)?
[...]

Not really, but let's take EIM approach, what's your goal/mission?

Or.
