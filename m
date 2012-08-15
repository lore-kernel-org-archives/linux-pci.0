Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:52151 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab2HOOtg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 10:49:36 -0400
Received: by ghrr11 with SMTP id r11so1847727ghr.19
        for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 07:49:35 -0700 (PDT)
Message-ID: <502BB7A2.7040304@gmail.com>
Date: Wed, 15 Aug 2012 22:52:18 +0800
From: Yijing Wang <wangyijing0307@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: Re: Do we need acpiphp_sanitize_bus() in acpiphp?
References: <502BAEA5.5080505@gmail.com> <CAErSpo4nFeDPvWeWmbXgmiRKWDNaeA44uwFbOLOWUhi-gLp5ag@mail.gmail.com>
In-Reply-To: <CAErSpo4nFeDPvWeWmbXgmiRKWDNaeA44uwFbOLOWUhi-gLp5ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Wed, Aug 15, 2012 at 7:13 AM, Yijing Wang <wangyijing0307@gmail.com> wrote:
>> Hi all,
>>    I have some confusion on acpiphp_sanitize_bus() functions.If I understand wrong about this, correct me,thanks your help.
>>    I think there are three problems in this function:
>>    1、Use list_for_each_entry here is not safe, because pci_stop_and_remove_bus_device() will remove the device from bus.
>>    2、If assign resources fail after hot-add a device, the resource will reset to zero, in reset_resource(), res->start = 0,
>>       res->end =0, res->end = 0.
>>    3、I think leave the fail pci devices in the system is better rather than remove them, so we can see all pci devices
>>       by lspci after hot-add, what about your opinion?
> 
> These sound like reasonable concerns.  The best thing to do is to
> propose patches (separate ones for each logical issue).  Then we can
> review a concrete change and apply it if appropriate.
> 
Hi Bjorn,
   Thanks for your comments!
   You are right, I will provide some patches as soon.
