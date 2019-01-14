Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA7C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 16:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE51120873
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 16:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfANQTU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:19:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36980 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfANQTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 11:19:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so23578318wrt.4
        for <linux-pci@vger.kernel.org>; Mon, 14 Jan 2019 08:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5HdUBRaRlZQz9yWxSlhub/8U7MERUTv8pJwUncl8mM0=;
        b=F15Jtdc72O2tdXRDG8lfLqb86/BWUYvJ7HWwOQIicSfOlUkxsIcPy9WMHEXuHEPJJF
         xxRjyh/D5wNjBnpp3MtuUf9/4C6yuzxW012wgzeE+DRpqArbHL89qjSav6l8jLLMNLn3
         bIgV112ra511iIpaiBIOkv5IlRHbwoEu0hF+fbQM64vW8o3mmMkcX1gb7yH5rydMEzqN
         5ihxQnrH6ZEV6oYbc9wBEgc6yiD5dusejX2PjG6redtP00eX58ztNOAAa8GZQCPPctMC
         l2zKSUEUhjFCwrejsuoPPtmKBhDc/RNMvIwF6JlGM4RKCpU1eMsqHVMtjYrovMyqagLC
         5sMQ==
X-Gm-Message-State: AJcUukdZCuoywPqTYQVoXXyyhlJaw7GaW+wVawozBCvR3Rc65UbFmK6h
        XE0u81N6jT8fdQvn+usNw4d0SA==
X-Google-Smtp-Source: ALg8bN42BuxJHQ5uWV9pbhwTPXWtmYgpWu/57RorjojMAGgvynUYfvbrsNPBEt6l2DkOg2vLoCZ1/w==
X-Received: by 2002:adf:a4d9:: with SMTP id h25mr23591947wrb.167.1547482752736;
        Mon, 14 Jan 2019 08:19:12 -0800 (PST)
Received: from localhost.localdomain ([151.15.254.62])
        by smtp.gmail.com with ESMTPSA id b18sm60396976wrr.43.2019.01.14.08.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:19:12 -0800 (PST)
Date:   Mon, 14 Jan 2019 17:19:10 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux Kernel
 III edition (OSPM-summit 2019)
Message-ID: <20190114161910.GB5581@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Power Management and Scheduling in the Linux Kernel (OSPM-summit) III edition
May 20-22, 2019
Scuola Superiore Sant'Anna
Pisa, Italy

---

.:: FOCUS

The III edition of the Power Management and Scheduling in the Linux
Kernel (OSPM) summit aims at fostering discussions on power management
and (real-time) scheduling techniques. Summit will be held in Pisa
(Italy) on May 20-22, 2019.

Although scheduler techniques for reducing energy consumption while
meeting performance and latency requirements are the prime interest of
the summit, we welcome anybody interested in having discussions on the
broader scope of real-time systems, real-time and non-real-time
scheduling, tooling, debugging and tracing.

Feel free to have a look at what happened previous years:

 I  edition - https://lwn.net/Articles/721573/
 II edition - https://lwn.net/Articles/754923/

.:: FORMAT

The summit is organized to cover three days of discussions and talks.

The list of topics of interest includes (but it is not limited to):

 * Power management techniques
 * Real-time and non real-time scheduling techniques
 * Energy consumption and CPU capacity aware scheduling
 * Real-time virtualization
 * Mobile/Server power management real-world use cases (successes and
   failures)
 * Power management and scheduling tooling (configuration, integration,
   testing, etc.)
 * Tracing
 * Recap/lightning talks

Presentations can cover recently developed technologies, ongoing work
and new ideas. Please understand that this workshop is not intended for
presenting sales and marketing pitches.

.:: ATTENDING

Attending the OSPM-summit is free of charge, but registration to the
event is mandatory. The event can allow a maximum of 50 people (so, be
sure to register early!). Registrations open on February 22nd, 2019.

To register fill in the registration form available at
https://goo.gl/forms/33rgOC70ypRrrZV33.

While it is not strictly required to submit a topic/presentation (see
below), registrations with a topic/presentation proposal will take
precedence.

.:: SUBMIT A TOPIC/PRESENTATION

To submit a topic/presentation add its details to this list:
https://docs.google.com/spreadsheets/d/1s5JzAlPoISZFwvV6QajE3aPBGVaixdLb5ftamJ4Mn9U/edit?usp=sharing

(feel free to get inspired by last year list of accepted topics
https://docs.google.com/spreadsheets/d/1ZPfASW6zVOM3xQvOrcaDEf1c-Pxi1XnFukVYHHwGUq4/edit?usp=sharing)

Or, if you prefer, simply reply (only to me, please :) to this email
specifying:

- name/surname
- affiliation
- short bio
- email address
- title
- abstract
- 30min or 50min slot

Deadline for submitting topics/presentations is 8th of February 2019.
Notifications for accepted topics/presentations will be sent out on 22nd
of February 2019.

.:: VENUE

The workshop will take place at ReTiS Lab*, Scuola Superiore Sant'Anna,
Pisa, Italy. Pisa is a small town, walking distance from the city center
to the venue is 20 minutes, walking distance from the airport to the
city center is 30 minutes. More details are available from the summit
web page: http://retis.sssup.it/ospm-summit/#site

* https://goo.gl/maps/2pPXG2v7Lfp

.:: ORGANIZERS (in alphabetical order)

Luca Abeni (SSSA)
Patrick Bellasi (Arm)
Tommaso Cucinotta (SSSA)
Dietmar Eggemann (Arm)
Sudeep Holla (Arm)
Juri Lelli (Red Hat)
Lorenzo Pieralisi (Arm)
Morten Rasmussen (Arm)
Claudio Scordino (Evidence SRL)
