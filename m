Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F155BC43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 01:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B096F20873
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 01:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V98wdRwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B096F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeK1MLz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:11:55 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35939 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeK1MLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 07:11:55 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so21154947oix.3;
        Tue, 27 Nov 2018 17:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ak6FWbAcS8rbW0WQBIUkVGymq+T5wGziIfalMQzKqRw=;
        b=V98wdRwOqQyk6VmImNpKv50BXZ1ZR5x3zihruL5ZQm/uctJv6gyGXW6YIabrDFmaI6
         CvlOPTXGo77o9N37qq9EylPKpVBGn9gU0aok5wqB+fkBcw5dPyxcPGF2K2fH9gI9b71X
         hvCEuH0mq3fGHaNFmOQJOeKvTcGYW/xyULgyKM3JtyopNJS86o5/lNqPdnUpmZiYhCK6
         OMGf/NuHxS1JvpqWz/bDLTX4ZXzSXpPwMBlwh7eUeAK7mzhitmYa1028e47dlZKakgyO
         JOQTZj0mUTwK6NMJ0yoKlrsosU6hvhZ75PCs3ruVSIKe6d7obg+YjmsjTsjTlqXKbkHA
         JhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ak6FWbAcS8rbW0WQBIUkVGymq+T5wGziIfalMQzKqRw=;
        b=Zh+UaNc92AA+agXXE5eQbCWFdhrhc6YlHjkGuDAVDYi0XzuiENgjxKJoEuZ0M1wdmB
         o/6KmTNCPveWkPylMDmORT60DUMbp2EjuO2YM6ho1mVJjSWQRRx94gmu58+TO2owYkFk
         gnlEhifZOgs0Wf2Uo0lUp2kHsIjGhmQ5QS6Bijn3QBB80qljHC9BAjHkONzL8DSMRC5W
         WzRNtguM6sq0AQOPJXyW6JBnEqvIg4m0d+TJr4Xjyy1SQS5k9/9xfYhUcQabiqRF7wNK
         S1da57NPG8Zt/iM2zcBLZnA+/bBd1EW6R+HWn5Glw9/pry+QyvZaKMiE0XQ8AW8U0P+8
         8cmw==
X-Gm-Message-State: AGRZ1gKTLZ6q6+GE8CfOqXthgo3k3zEmPCz6SpTAuk6GoQl7G5cYFaZs
        9MqoU141zsMuQdhMq5N9+EFLtVmT23nYOK+QBWw=
X-Google-Smtp-Source: AJdET5eivPkThctXKzpLY+i7YedJBG5OBUSbkGOqK79AI4JAaG5RKivIWDjJM7XJBHmhmeb+1mhZNDYnrv8Ak5Xna48=
X-Received: by 2002:aca:de85:: with SMTP id v127-v6mr20033745oig.259.1543367529862;
 Tue, 27 Nov 2018 17:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20181120132705.6917-1-stefan@agner.ch> <20181120132705.6917-3-stefan@agner.ch>
 <CAHQ1cqEfjqtJbb6qxTRa-rVvgy8+_Og4Eh21XMRETJHnRG9a6w@mail.gmail.com>
In-Reply-To: <CAHQ1cqEfjqtJbb6qxTRa-rVvgy8+_Og4Eh21XMRETJHnRG9a6w@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 27 Nov 2018 23:12:03 -0200
Message-ID: <CAOMZO5DZRUUkkqNPRZWhK0C56sRU+eQqFzV+akpEvwcKHW1DNw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: imx6: limit DBI register length
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Stefan Agner <stefan@agner.ch>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Trent Piepho <tpiepho@impinj.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrey,

On Tue, Nov 27, 2018 at 10:57 PM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> Could this be a regression? Prior to 415b6185c541 ("PCI: imx6: Fix
> config read timeout handling") all of the imprecise aborts were caught
> and handled via no-op handler. I did an experiment on i.MX6Q board
> that I have (ZII RDU2) and adding a simple no-op for imprecise aborts
> via
>
> hook_fault_code(16 + 6, imx6q_pcie_no_op_handler, SIGBUS, 0,
>                        "imprecise external abort");
>
> seems to "resolve" this problem:

Please check https://patchwork.kernel.org/patch/9720313/

This commit fixed a kernel crash on mx6q boards with a PCI switch.

So we can't go back to the simple no-op.
