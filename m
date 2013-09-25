Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:57963 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220Ab3IYWWr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2013 18:22:47 -0400
Received: by mail-ie0-f180.google.com with SMTP id u16so385335iet.25
        for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2013 15:22:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <521EB76B.8090903@oracle.com>
References: <521EB76B.8090903@oracle.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Sep 2013 16:22:26 -0600
Message-ID: <CAErSpo5_Vhs5cN-1dUz051b+P0ZrUH1xuM+bkVe4C4ycMyLTNQ@mail.gmail.com>
Subject: Re: [PATCH 2/3 v3] Refactor MSI restore call-chain to drop
 unnecessary argument
To: zhenzhong.duan@oracle.com
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	xen-devel <xen-devel@lists.xen.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Feng Jin <joe.jin@oracle.com>,
	Sucheta Chakraborty <sucheta.chakraborty@qlogic.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 28, 2013 at 8:52 PM, Zhenzhong Duan
<zhenzhong.duan@oracle.com> wrote:
> ...
> -v3: Update patch description per Konrad suggestion, thanks.
>
> Tested-by: Sucheta Chakraborty <sucheta.chakraborty@qlogic.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>

Zhenzhong, would you mind reposting the entire series as a v4 with all
updates and acks?  I'm not sure I can collect all the right pieces.

Thanks,
  Bjorn
