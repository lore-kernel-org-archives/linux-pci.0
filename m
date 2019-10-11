Return-Path: <SRS0=SVWb=YE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB89BC47404
	for <linux-pci@archiver.kernel.org>; Fri, 11 Oct 2019 06:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C175B214E0
	for <linux-pci@archiver.kernel.org>; Fri, 11 Oct 2019 06:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2UM+LCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfJKGtY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:49:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35946 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfJKGtY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2019 02:49:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so5489235pfr.3;
        Thu, 10 Oct 2019 23:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lI3FmveMxynn8iWgzzKvDCiGa3J1be8OYxVDzXPfJSc=;
        b=D2UM+LCn4BVU41xDnmNgrqg5ccUwK+ssZ9iPB8fnVAq8LBzuIPXuTdkrZg3GfzMD7r
         PaXnKlymynij21lOqOTX2zG4+0GVULLFIM872lKhPwFHB/yQ2Kh0iupeXlUjKqFXqdrt
         VUpwuUpg2IZAE7hHDt/xoyrSqIfGX+gZ+u8UsQTEAB7BIAqzii4HGDJf0PYAdI2tJZ5W
         hFVkRHh5bJ0GNgGT0OvJFTRw0Upe+px+4gkM+vIBtI281JYDVYWqCJLCdg4Kd5fjmujF
         CvEs2mLMo+mRvSFnV4GGbnHflFL55jU5wvs6+uHy/zNtEOn15qcOPEU2pwF8MQviUu8e
         OjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lI3FmveMxynn8iWgzzKvDCiGa3J1be8OYxVDzXPfJSc=;
        b=Dfhn7C4n9GfWpGFKTef59v3NxzTCrN/jaJtv8282YP+h/kWCdxTWl11jj7I4B9u/Tt
         jDY5I8ky3czGEYpUW0XRi/3Nw9FthC/uEzZzmgRO3HGM/w8kCRuHUSKHVyBBbNG0cjGf
         plh42W+v6jsQq+Y/C+9Xp69i5JMNwd6gTYtlfTP1EglKNBBBJ/Hj7RCb1lMepQc+DsXU
         HJ8DxhDAbqtVfe6PdGUJQlZjEWl8tQMrRgJJT6I1DtFu6bnL6oIVwTNCSunqiUL13mxw
         kVM5X9CNodKYGmALK432fc8wNzXG4buvvGykEOTrq9Z+CdRKqI9nJbJ1gOyGIWeaXDgM
         AM3w==
X-Gm-Message-State: APjAAAXS7zt9H2/+PI67jLFki3y3jLraBdgC0KyxiIhU2uhcAvnLJU4G
        9W5q2odfE+uoxEckgukFHMZ45uSAoHXIaO5nnXM=
X-Google-Smtp-Source: APXvYqxF4rgMB7mne3YjI7BIX+QLFeyDlO+TStNyEyk5w4cEM+xVJbqKgH+/enJJhaB4QOx7heUTxxME91AQep5JZug=
X-Received: by 2002:a62:e206:: with SMTP id a6mr14818167pfi.64.1570776563039;
 Thu, 10 Oct 2019 23:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191009200523.8436-1-stuart.w.hayes@gmail.com>
 <20191009200523.8436-3-stuart.w.hayes@gmail.com> <CAHp75Vc1mZ7qxKPGaqDVAQ9d_UjNq9LJDEPWHQHaYCfw7vGrmA@mail.gmail.com>
 <CAHp75VfNjnAxua6ESx1Vp=57O=pVM10P1UK8bGNQUk7FeY=Dmw@mail.gmail.com> <CAL5oW02uRk-ZLMaE6Skt7rX6xy=sQNttfSZ2N1JRBXPfjJpZNg@mail.gmail.com>
In-Reply-To: <CAL5oW02uRk-ZLMaE6Skt7rX6xy=sQNttfSZ2N1JRBXPfjJpZNg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Oct 2019 09:49:11 +0300
Message-ID: <CAHp75VfEpH4Nv0J+wc3vhFWXYgVLcFdOr263dAFRZiz_ZEfZrw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 10, 2019 at 11:37 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:

> Thank you for the feedback!  An infinite loop is used several other places in
> this driver--this keeps the style similar.  I can change it as you suggest,
> though, if that would be preferable to consistency.

Better to start the change now. I'll look into the file and see how we
can improve the rest.

-- 
With Best Regards,
Andy Shevchenko
