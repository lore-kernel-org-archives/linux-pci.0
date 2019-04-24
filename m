Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B176C282E1
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 18:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E5D2089F
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 18:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556130508;
	bh=ppHcFL6zapxMV7/RB/euSIWPcUPX3BPdSNKeNM1Qi+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VEiureo2D+7AHQleIobpe+AyBgjt+O+4unvZUz5vVpFKwdcaXWpoLqic+9eJ1mLgG
	 zcrf/2k5R62AwSFf0SmzdbVD+LSYL3OowlxtQf8zQZprX+GTEgxtv0sRFIWNf/Hpkk
	 qohf14Ml/jRUiWv7Y7cs1EVcYO45EnQ2ZY7ngY8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbfDXS21 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733047AbfDXS21 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Apr 2019 14:28:27 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5E7206A3;
        Wed, 24 Apr 2019 18:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556130506;
        bh=ppHcFL6zapxMV7/RB/euSIWPcUPX3BPdSNKeNM1Qi+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l9P+oABbet1Nb/DtFG1cdsxlFvzX1ZXE2rbHyYMACJpZeVnTSjdsQXjnsUh8Gh6BB
         07RTXoUztbg0pumo9SdBCc6LL/wRy4P1Cy8S5On2vRNwSgPzHce5bB+x0GDG5x45w7
         hL5mL2qrsdeWq7Eqh/3kSAB3dmpqbL5Cjh6OT8TI=
Date:   Wed, 24 Apr 2019 13:28:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     David Ober <dober@lenovo.com>, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] pci/quirks: Add quirk to reset nvgpu at boot for the
 Lenovo ThinkPad P50
Message-ID: <20190424182824.GA11428@google.com>
References: <20190212220230.1568-1-lyude@redhat.com>
 <20190215004329.GR96272@google.com>
 <2fca9a9feafcd17b27bc71994a71ebc241a93e9a.camel@redhat.com>
 <52b17f8cb24e179e9661d75548d193843ae87b4c.camel@redhat.com>
 <20190321224819.GK251185@google.com>
 <20190322113015.GM251185@google.com>
 <20190404141724.GJ141706@google.com>
 <389c7b3117168209fb4760537d908a477446d013.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389c7b3117168209fb4760537d908a477446d013.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 01:31:09PM -0400, Lyude Paul wrote:
> Any update on this? This has been waiting for a while now

Oh, sorry, I guess we were both waiting for the other.  Let me respond to
the email with context.

> On Thu, 2019-04-04 at 09:17 -0500, Bjorn Helgaas wrote:
> > [+cc Hans, author of 0b2fe6594fa2 ("drm/nouveau: Queue hpd_work on (runtime)
> > resume")]
> -- 
> Cheers,
> 	Lyude Paul
> 
