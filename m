Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A041DC282CE
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 18:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6846620863
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 18:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipssB9oQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfDES30 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:29:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39576 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbfDES30 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Apr 2019 14:29:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id b65so3461139plb.6;
        Fri, 05 Apr 2019 11:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=71zxO+3RgkOG48rQkFIqJMveOCUt6KsJU18Cau9oLO4=;
        b=ipssB9oQiLMzivHetEDYyj0SDVzOvp+URZYcCB/dhy2KT2NWDycTy8pWZzZKSPMKPL
         3j2Yx568scEOWbJsx4zVdEGevWNe3ZfPLhWipQlSrLhQIoTrFA1BI0Ev1wNRJ9aBPHLx
         W6cTsMJKieJfJ7H5I2bgOlbmgXuZrWJMdpm2pg3rjSrt5XVAEMqSO7fuQ7eQmpvFPkMw
         zXv8oXt6Lyo0j/lv1z954bmh1yw3Pq5acIm3cPHbxcewTC3lYs8kMDiJ9CLAD+nEStcc
         Z31aqN6yG3c+QWvthcBMPDKv6EMyYNmlNGyO8OsM9H8pbkMRHr2A0q35KZpUDul0HaNH
         4pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=71zxO+3RgkOG48rQkFIqJMveOCUt6KsJU18Cau9oLO4=;
        b=VA0QiUgn+Sbj/ABYEcDh74fvAL+hc4oBsEcgg7eYmrYryjGpMF4pkGc4MC8HB2RMjE
         AG4UkEYqggZznV6+UHHIDcMHPqimkKGzBqv9ybexBkqlnNm2I0hIwDOKHpCtQ07odsjp
         VnOKGWfO04l5ykm+LRa6O7M1hpn71vhkTwvNMIN/LVdqLcW7cO8AqjT584Nc43CyNSEo
         aLxZ/7kxGtLMzTMYKfHyrQ886pgqShPXEW3dgGFQGibsA1vfMmT6CN4ioj/TAM8p6dmx
         zilGxklt4xzSKajEOMAbFvNTFXWpsznlQyi37haf9LcdsoV30gIIHzbHAixQF9aaqjTS
         o8pw==
X-Gm-Message-State: APjAAAU3eB8R+hlTrKbO+65spdM41NMz6IIgXreDydMAeQ1x1luXU3Vf
        NRxIryuTSTEZ8Cq3qmbMpRs=
X-Google-Smtp-Source: APXvYqzzvExXt142yVBlHCBB0352pnU5JZM9Hx+kwx/Q493jkClFsy0XjeqXC6tVj7mQNxoyyMYrig==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr14707327pls.54.1554488965353;
        Fri, 05 Apr 2019 11:29:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i13sm26975273pgq.17.2019.04.05.11.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 11:29:24 -0700 (PDT)
Date:   Fri, 5 Apr 2019 11:29:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, wangkefeng.wang@huawei.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de, rafael@kernel.org,
        linux-pci@vger.kernel.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        andy.shevchenko@gmail.com, catalin.marinas@arm.com, bp@suse.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
Message-ID: <20190405182923.GA11563@roeck-us.net>
References: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
 <1554393602-152448-4-git-send-email-john.garry@huawei.com>
 <20190404164130.GA12203@roeck-us.net>
 <24cc8006-0f0d-6b20-a466-e4a32a0bb656@huawei.com>
 <20190404174336.GA10404@roeck-us.net>
 <20190404185815.GA26522@google.com>
 <2d0f583a-cabe-df4e-ad89-c1800d9b4804@huawei.com>
 <20190405180615.GB109021@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405180615.GB109021@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 05, 2019 at 01:06:15PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 05, 2019 at 09:10:27AM +0100, John Garry wrote:
> > On 04/04/2019 19:58, Bjorn Helgaas wrote:
> > > On Thu, Apr 04, 2019 at 10:43:36AM -0700, Guenter Roeck wrote:
> > > > On Thu, Apr 04, 2019 at 05:52:35PM +0100, John Garry wrote:
> > > > > > > Note that the f71805f driver does not call
> > > > > > > request_{muxed_}region(), as it should.
> > > > > 
> > > > > > ... which is the real problem, one that is not solved by this
> > > > > > patch. This may result in parallel and descructive accesses if
> > > > > > there is another device on the LPC bus, and another driver
> > > > > > accessing that device. Personally I'd rather have
> > > > > > request_muxed_region() added to the f71805f driver.
> > > > > 
> > > > > Right, we should and will still fix f71805f. If you recall, I did
> > > > > have the f71805f fix in the v1 series, but you committed that it
> > > > > was orthogonal, so I decided to take it out of this work for now.
> > > > > 
> > > > > And even if we fix up f71805f and other known drivers which don't
> > > > > call request_muxed_region(), we still need to police against these
> > > > > rogue accesses, which is what this patch attempts to do.
> > > > > 
> > > > Do we ? I am personally not convinced that LPC accesses _have_ to
> > > > occur through PCI on any given system.
> > > 
> > > On current systems, I suspect ISA/LPC devices are typically connected
> > > via a PCI-to-ISA/LPC bridge.  But AFAIK there's no actual requirement
> > > for that bridge, and there certainly *were* systems with ISA devices
> > > but no PCI at all.
> > > 
> > > IMO, if you want to build ISA drivers on your arch, you need to make
> > > sure the inb() probing done by those drivers works like it does on
> > > x86.  If there's no device there, the inb() should return 0xff with no
> > > fuss and no crash.
> > 
> > Right, and this is what I am attempting to do here.
> > 
> > So today a call to request_muxed_region() can still succeed even if no IO
> > space mapped.
> > 
> > As such, even well-behaved drivers like f71882fg can still crash the system,
> > as noted in RFC patch 1/4 ("resource: Request IO port regions from children
> > of ioport_resource").
> 
> Maybe I'm missing something, but on x86, drivers like f71882fg do not
> crash the system because inb() *never* causes a crash.
> 
> If you want to build that driver for ARM, I think you need to make
> sure that inb() on ARM also *never* causes a crash.  I don't think
> changing f71882fg and all the similar drivers is the right answer.
> 

Agreed. As I had mentioned earlier, the driver changes are orthogonal:
the drivers should request the IO region before accessing it, primarily
to avoid conflicting accesses by multiple drivers in parallel. For
example, the f71882fg driver supports chips which implement hardware
monitoring as well as watchdog functionality, and both the hwmon
and the watchdog driver may try to access the io space.

If and how the system ensures that the IO region exists and/or that 
inb() always succeeds is a different question. I would prefer a less
complex solution than the one suggested here, but that is my personal
opionion.

Guenter
