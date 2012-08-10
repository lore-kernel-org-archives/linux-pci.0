Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:44141 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab2HJQlA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Aug 2012 12:41:00 -0400
MIME-Version: 1.0
In-Reply-To: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
Date: Fri, 10 Aug 2012 09:41:00 -0700
Message-ID: <CAE9FiQUZ+EHDGfAVU4wkYepT-97UVAkUNsKds4QVRJv=eNUTdQ@mail.gmail.com>
Subject: Re: [PATCH 0/7][RESEND] acpi, pci: hostbridge hotplug support
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 9, 2012 at 11:09 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>  Hi all,
>
>
>  I'd like to merge hostbridge hotplug feature.
>  I looked at Yinghai's branch and found that this branch contains
>  many work and can be split into some parts.
>  I believe it is good to merge step by step.
>
>  My idea is splitting into the following 4 parts:
>    1. basic hostbirdge hotplug work
>    2. acpiphp work
>    3. /sysfs interface work (logical hotplug?)
>    4. cleanup
>
>  This patchset is 1st step based on the following Yinghai's branch:

Hi,

Are you going to attend PCI mini-summit 8/28? We should discuss there.

Thanks

Yinghai
