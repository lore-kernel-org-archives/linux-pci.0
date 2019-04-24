Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37806C282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 17:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12756218B0
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 17:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391416AbfDXRsY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:48:24 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:39665 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403771AbfDXRbN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 13:31:13 -0400
Received: by mail-qk1-f176.google.com with SMTP id f125so6514815qke.6
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2019 10:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=eTLISjJwUHw4lGNfrwxk/71GLv53QQdcgiYYf8SrSz8=;
        b=qoKLrRvclaV+dgOibvbqqijtpu/s3MxzgpyWhZ+1tAwHDRdF/qaE1THeOsvcN6TZ3z
         Th2GMSgr2yPUGyuqoeQ73sJ4c94sca/jgOFCIfCCmSA8W1g0jTmBfXOW8xl4XvjcUY4+
         2MtZkEhx06yR4kK6rL3sjDCSIvT+3grjFawkLmstMb8qt5uIv3pG3/PR2O14tnWytbAZ
         cMqHHa8TZ0YhF47U/U2BLy5hPiis7y5LXJWxeTov2+HYeTn/YzZJ89FQ2fi/uzScdCR2
         lfYWBTu2HjlZ5XT5Txxg+xKVht7DNX2dGwDkVLEyhcJaK2yYkmf1RoH9kaQGltaEyMwU
         /zTA==
X-Gm-Message-State: APjAAAUdRgslHfHnO+vaSH4CjCWYHHBDBoCJ4ZdZoz69f6vccnU4H0v5
        g+2yaUyzfSnqtLQZ6gWLT9rb5g==
X-Google-Smtp-Source: APXvYqznV0AJ6erOiLOlUEASHstK+DGsKzve9fJWwdmDag6YPj1a2AtQeaFI0O3mX9Arf5lCDAh45w==
X-Received: by 2002:a37:7d87:: with SMTP id y129mr23981785qkc.43.1556127072054;
        Wed, 24 Apr 2019 10:31:12 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id y7sm6584776qki.14.2019.04.24.10.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 10:31:11 -0700 (PDT)
Message-ID: <389c7b3117168209fb4760537d908a477446d013.camel@redhat.com>
Subject: Re: [PATCH] pci/quirks: Add quirk to reset nvgpu at boot for the
 Lenovo ThinkPad P50
From:   Lyude Paul <lyude@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Ober <dober@lenovo.com>, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Wed, 24 Apr 2019 13:31:09 -0400
In-Reply-To: <20190404141724.GJ141706@google.com>
References: <20190212220230.1568-1-lyude@redhat.com>
         <20190215004329.GR96272@google.com>
         <2fca9a9feafcd17b27bc71994a71ebc241a93e9a.camel@redhat.com>
         <52b17f8cb24e179e9661d75548d193843ae87b4c.camel@redhat.com>
         <20190321224819.GK251185@google.com> <20190322113015.GM251185@google.com>
         <20190404141724.GJ141706@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Any update on this? This has been waiting for a while now

On Thu, 2019-04-04 at 09:17 -0500, Bjorn Helgaas wrote:
> [+cc Hans, author of 0b2fe6594fa2 ("drm/nouveau: Queue hpd_work on (runtime)
> resume")]
-- 
Cheers,
	Lyude Paul

