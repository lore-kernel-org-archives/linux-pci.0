Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6A0C10F00
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 07:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D5B20989
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 07:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfBYHnk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Feb 2019 02:43:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56058 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfBYHnj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Feb 2019 02:43:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id q187so7018860wme.5
        for <linux-pci@vger.kernel.org>; Sun, 24 Feb 2019 23:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CG3BRS/l1MjriflAwElo+ie+Ydx2jv0npadHm8oQxgw=;
        b=uB9xds65AGT0sFiZGXnh7uF2UabKv/tpG8atD24Zy7ARXcG6elSXhbp1dzlGhxBUQm
         cm2cHHODyASzoCywCQlALnUya0XhL7nDRPQKcyqw86Q/L9EuCKq6EYySBStTlFVUN/i0
         yZ4UqPKOw5dzzu0HhYQgUz/e6kquPGcIe+esgvtGJLLIvDdGA4O1Bf2dvVRNmEiX70gw
         QKtibfTWYhzTBWb1fR1dIRT3G0A/Z6533oCKZhHRUfSUAKiKOS8bGO/R0ltsQ+bEDQqI
         4t+MM92HV2JdYarxCwfpJb9nOoO/mrnL974iWU+HVwOrHHLiASsuPZrfcdIJ0ALnl+cI
         u6mA==
X-Gm-Message-State: AHQUAuZ3aNPG/Kecc3uJxEjPssnOuflneYPQ3CnBNtU15E/G/FCWyTdM
        hDrkTXUtgJXyMVulBF7q3aAOwg==
X-Google-Smtp-Source: AHgI3IakneO1367QzzHzxFLeL6t8EpmgQG0dN/D+wqLiRDLQHNNMSJ4KFt4lCmL2sk+eQ9NUBLuSTA==
X-Received: by 2002:a1c:bcd7:: with SMTP id m206mr3877466wmf.36.1551080616070;
        Sun, 24 Feb 2019 23:43:36 -0800 (PST)
Received: from localhost.localdomain ([151.15.254.225])
        by smtp.gmail.com with ESMTPSA id z129sm15093886wmc.33.2019.02.24.23.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 23:43:35 -0800 (PST)
Date:   Mon, 25 Feb 2019 08:43:33 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel III edition (OSPM-summit 2019)
Message-ID: <20190225074333.GH21785@localhost.localdomain>
References: <20190114161910.GB5581@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114161910.GB5581@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

A quick one to inform everybody that registrations are now open!

Although list of topics looks pretty good already, we are still
accepting new ones. So, please don't hesitate to add your.

Best,

- Juri

On 14/01/19 17:19, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) III edition
> May 20-22, 2019
> Scuola Superiore Sant'Anna
> Pisa, Italy
> 
> ---
> 
> .:: FOCUS
> 
> The III edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. Summit will be held in Pisa
> (Italy) on May 20-22, 2019.
> 
> Although scheduler techniques for reducing energy consumption while
> meeting performance and latency requirements are the prime interest of
> the summit, we welcome anybody interested in having discussions on the
> broader scope of real-time systems, real-time and non-real-time
> scheduling, tooling, debugging and tracing.
> 
> Feel free to have a look at what happened previous years:
> 
>  I  edition - https://lwn.net/Articles/721573/
>  II edition - https://lwn.net/Articles/754923/
> 
> .:: FORMAT
> 
> The summit is organized to cover three days of discussions and talks.
> 
> The list of topics of interest includes (but it is not limited to):
> 
>  * Power management techniques
>  * Real-time and non real-time scheduling techniques
>  * Energy consumption and CPU capacity aware scheduling
>  * Real-time virtualization
>  * Mobile/Server power management real-world use cases (successes and
>    failures)
>  * Power management and scheduling tooling (configuration, integration,
>    testing, etc.)
>  * Tracing
>  * Recap/lightning talks
> 
> Presentations can cover recently developed technologies, ongoing work
> and new ideas. Please understand that this workshop is not intended for
> presenting sales and marketing pitches.
> 
> .:: ATTENDING
> 
> Attending the OSPM-summit is free of charge, but registration to the
> event is mandatory. The event can allow a maximum of 50 people (so, be
> sure to register early!). Registrations open on February 22nd, 2019.
> 
> To register fill in the registration form available at
> https://goo.gl/forms/33rgOC70ypRrrZV33.
> 
> While it is not strictly required to submit a topic/presentation (see
> below), registrations with a topic/presentation proposal will take
> precedence.
> 
> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation add its details to this list:
> https://docs.google.com/spreadsheets/d/1s5JzAlPoISZFwvV6QajE3aPBGVaixdLb5ftamJ4Mn9U/edit?usp=sharing
> 
> (feel free to get inspired by last year list of accepted topics
> https://docs.google.com/spreadsheets/d/1ZPfASW6zVOM3xQvOrcaDEf1c-Pxi1XnFukVYHHwGUq4/edit?usp=sharing)
> 
> Or, if you prefer, simply reply (only to me, please :) to this email
> specifying:
> 
> - name/surname
> - affiliation
> - short bio
> - email address
> - title
> - abstract
> - 30min or 50min slot
> 
> Deadline for submitting topics/presentations is 8th of February 2019.
> Notifications for accepted topics/presentations will be sent out on 22nd
> of February 2019.
> 
> .:: VENUE
> 
> The workshop will take place at ReTiS Lab*, Scuola Superiore Sant'Anna,
> Pisa, Italy. Pisa is a small town, walking distance from the city center
> to the venue is 20 minutes, walking distance from the airport to the
> city center is 30 minutes. More details are available from the summit
> web page: http://retis.sssup.it/ospm-summit/#site
> 
> * https://goo.gl/maps/2pPXG2v7Lfp
> 
> .:: ORGANIZERS (in alphabetical order)
> 
> Luca Abeni (SSSA)
> Patrick Bellasi (Arm)
> Tommaso Cucinotta (SSSA)
> Dietmar Eggemann (Arm)
> Sudeep Holla (Arm)
> Juri Lelli (Red Hat)
> Lorenzo Pieralisi (Arm)
> Morten Rasmussen (Arm)
> Claudio Scordino (Evidence SRL)
