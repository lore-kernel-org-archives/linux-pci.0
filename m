Return-Path: <SRS0=nbQ7=ZG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD117C432C3
	for <linux-pci@archiver.kernel.org>; Thu, 14 Nov 2019 08:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F9E206F0
	for <linux-pci@archiver.kernel.org>; Thu, 14 Nov 2019 08:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D31R4REI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfKNIve (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:51:34 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45019 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNIve (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Nov 2019 03:51:34 -0500
Received: by mail-oi1-f173.google.com with SMTP id s71so4543818oih.11
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2019 00:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XsJZZBmHWs3oTUecsrmJsTbZW2qXyVQWSBFHP3MYq1w=;
        b=D31R4REIuPhPkh7gI+AhFWIawJQ7SB2IRl33UYvqHRbgtC/RiQvXz8HxcsgLBxGBhe
         4Bg/1NGsfcfigkp8JJdAkE5Rv87jNaDJLjTqESom3qTNdPpBJ3RFfL7PjPJZhLbKO8u4
         eKqEcI065u85tpDGY7YMBsgdUi7PCNSCVqSU0nvV+e3uD3dlMDsZtZz38AGtOjvbj6o9
         Ydp1qaKJC151J1YFMFckg0/xCEPVeFbLlwzapaQFMhu00+Z94WhH+TC51S3FvJC8jOST
         q+sOJtjsWkp/wQZpan7T/2M1W9NIiWyUxcklyhaTGZewyCRgzzcLwDEUqeTdybS9MvBa
         dXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XsJZZBmHWs3oTUecsrmJsTbZW2qXyVQWSBFHP3MYq1w=;
        b=J1T2TQzf5zvYWar2FgRM22yDZmBz07wQVgfuGggoew+XlGOW6BTTqJB5oYDCj1GvVD
         FdYfJZUDS/JLaySGOg+MMhT0+7WOufegA1bR/2yGGCw6T5DehZfXE1Axwjjub7y9hHiE
         Hkc4B+n4My8+ImOOHf36J9wpIUxovYd3/C0kdVWIQGS0nVowANNKkpesPCWmL8x9NoOT
         zyfFWgEJ9Ih0+zZun5r0D5orEATmOpQDb2U29Q8hAtq8pxLYMQE3PQH4mkH5b9V8U03P
         1O3Ma2iscMUbR8tuTdrVcm9VmuREzcnVCkEy5Ph0caEYGDo+0dNRpND7U9NbhiBULkzU
         kbkA==
X-Gm-Message-State: APjAAAWQ3KJ824bM0YhpaL9KX43aexhHEIGmxZo/cMkutED5KOK+7IzX
        8tV0ilKyMCEL7vpfdzvJbvC6/GC/jxMfSwxQ4bvdzKz/
X-Google-Smtp-Source: APXvYqwF5Pv7Az1duMeHCJhRjMDhdJzzZbtHjmr2CWOI7znClzFsaJ1NROnAF2nAkX8ERfRjgKIQ7lncIClwH65QMw8=
X-Received: by 2002:aca:c508:: with SMTP id v8mr2486058oif.31.1573721492776;
 Thu, 14 Nov 2019 00:51:32 -0800 (PST)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Thu, 14 Nov 2019 14:21:21 +0530
Message-ID: <CAHhAz+j+pN3fy_9NTBBchuz_X1a-FQK0Lt8ty3sk3qkufH7KYQ@mail.gmail.com>
Subject: Question about pci_alloc_consistent() return address
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

 I=E2=80=99m using pci_alloc_consistent() in PCIe driver. My PCIe device on=
ly
works 64 bit data  boundary transactions.

Is there a way to make sure pci_alloc_consistent() always returns
64-bit aligned address?


--=20
Thanks,
Sekhar
