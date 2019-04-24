Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63101C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 16:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E9521900
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 16:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1fAS9bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfDXQJ6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:09:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47005 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731514AbfDXQJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 12:09:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id o7so7281260pll.13;
        Wed, 24 Apr 2019 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RqxUs6wYdyM7g96unmSFf8msAzU8W2f6PNULPv2JYwM=;
        b=d1fAS9bKXuy4T8O9b7beyDdPxIW2e8uXVKFbcuQDyuHy0kvaYHZPPnS+ZfXm7Ya1Fg
         IJbkZvi4GzGY134v/b3N8ZsYxgTJUsNkl98QHHVhL4oHXjJdkWVcIvxmFiD21vDKSx7b
         ZDn7VVsVS0QkOUDD4XbwcMHwExjQBuIZEPdbsW6o4HxeBfmBVMt5G5MPfWEFKXD3B77E
         fBDPlqFbLfaY6fv20Sz3Y+TYvkhFV2uTwrzRtBmuwmjzvAWJ+XmuwGGk0ydF1r4DlxA4
         MeUFpz60cm890hw9WPRMzOEIA0jo+i5Jc574PQb9za4AXg7CafVrXVXiMc6h+cwDKQEl
         lXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RqxUs6wYdyM7g96unmSFf8msAzU8W2f6PNULPv2JYwM=;
        b=JhWMs4mPXuM9k7uHzEZm0DMLtMavRstkvCA0E/ZZ89dJx6bJtkNxoI7Uljdog6hXqm
         zDeHD75w1oSMH/VdXOBQYEq0f+mYyHhExX00EQzRU2cMZA6ERMSlEwvVWZu4FBfhmrvJ
         THlMU0iV1VjHA3Lli6Rw0TiONPGgLT3uQOeVTF3Ok6D+USnYjZ8AzHhU1WiWIDD7392B
         +YdiKwA++QV+j3CIRe1r6FqYVHEQlCe7HZ6OWYh3O8bGJc4pYKhjcnDVG19EN04TZFrs
         0D7SKGbfphOVvFvI7njCGlGJSUkSD578NOAfjfW5TKKsb2tkGdq7bsNeH9+7+z61Ky/X
         4c6A==
X-Gm-Message-State: APjAAAUmUQ+4iEBmMvK0h+r8YrSRSknLvnYWrr5hF6XwjOczFqIaBUVC
        lieaIXT02Dwc+k3yz1X566g=
X-Google-Smtp-Source: APXvYqwkOx4UWzUkw1Z4V0EJXzG0+k5fqV01VCHNCe5zL21WYYEh9uiX/KBjj/Nfk09dKVeLjBaFAw==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr33482206ple.62.1556122196491;
        Wed, 24 Apr 2019 09:09:56 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 90sm5338286pfr.55.2019.04.24.09.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 09:09:55 -0700 (PDT)
Date:   Thu, 25 Apr 2019 00:09:45 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 02/63] Documentation: ACPI: move namespace.txt to
 firmware-guide/acpi and convert to reST
Message-ID: <20190424160943.ujekxggejg6sb452@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-3-changbin.du@gmail.com>
 <20190423173840.2e450b34@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423173840.2e450b34@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 05:38:40PM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:28:31 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  Documentation/firmware-guide/acpi/index.rst   |   1 +
> >  .../acpi/namespace.rst}                       | 310 +++++++++---------
> >  2 files changed, 161 insertions(+), 150 deletions(-)
> >  rename Documentation/{acpi/namespace.txt => firmware-guide/acpi/namespace.rst} (54%)
> > 
> > diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> > index 0ec7d072ba22..210ad8acd6df 100644
> > --- a/Documentation/firmware-guide/acpi/index.rst
> > +++ b/Documentation/firmware-guide/acpi/index.rst
> > @@ -7,3 +7,4 @@ ACPI Support
> >  .. toctree::
> >     :maxdepth: 1
> >  
> > +   namespace
> > diff --git a/Documentation/acpi/namespace.txt b/Documentation/firmware-guide/acpi/namespace.rst
> > similarity index 54%
> > rename from Documentation/acpi/namespace.txt
> > rename to Documentation/firmware-guide/acpi/namespace.rst
> > index 1860cb3865c6..443f0e5d0617 100644
> > --- a/Documentation/acpi/namespace.txt
> > +++ b/Documentation/firmware-guide/acpi/namespace.rst
> > @@ -1,85 +1,88 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. include:: <isonum.txt>
> > +
> > +===================================================
> >  ACPI Device Tree - Representation of ACPI Namespace
> > +===================================================
> > +
> > +:Copyright: |copy| 2013, Intel Corporation
> > +
> > +:Author: Lv Zheng <lv.zheng@intel.com>
> > +
> > +:Abstract: The Linux ACPI subsystem converts ACPI namespace objects into a Linux
> > +           device tree under the /sys/devices/LNXSYSTEM:00 and updates it upon
> > +           receiving ACPI hotplug notification events.  For each device object
> > +           in this hierarchy there is a corresponding symbolic link in the
> > +           /sys/bus/acpi/devices.
> > +           This document illustrates the structure of the ACPI device tree.
> 
> Well, this is a matter of preference. I would add Abstract as a chapter,
> as this would make it part of the top index, with can be useful. 
>
Now it becomes a chapter. Thanks.

> In any case:
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> > +
> > +:Credit:   Thanks for the help from Zhang Rui <rui.zhang@intel.com> and
> > +           Rafael J.Wysocki <rafael.j.wysocki@intel.com>.
> > +
> > +
> > +ACPI Definition Blocks
> > +======================
> > +
> > +The ACPI firmware sets up RSDP (Root System Description Pointer) in the
> > +system memory address space pointing to the XSDT (Extended System
> > +Description Table).  The XSDT always points to the FADT (Fixed ACPI
> > +Description Table) using its first entry, the data within the FADT
> > +includes various fixed-length entries that describe fixed ACPI features
> > +of the hardware.  The FADT contains a pointer to the DSDT
> > +(Differentiated System Descripition Table).  The XSDT also contains
> > +entries pointing to possibly multiple SSDTs (Secondary System
> > +Description Table).
> > +
> > +The DSDT and SSDT data is organized in data structures called definition
> > +blocks that contain definitions of various objects, including ACPI
> > +control methods, encoded in AML (ACPI Machine Language).  The data block
> > +of the DSDT along with the contents of SSDTs represents a hierarchical
> > +data structure called the ACPI namespace whose topology reflects the
> > +structure of the underlying hardware platform.
> > +
> > +The relationships between ACPI System Definition Tables described above
> > +are illustrated in the following diagram::
> > +
> > +   +---------+    +-------+    +--------+    +------------------------+
> > +   |  RSDP   | +->| XSDT  | +->|  FADT  |    |  +-------------------+ |
> > +   +---------+ |  +-------+ |  +--------+  +-|->|       DSDT        | |
> > +   | Pointer | |  | Entry |-+  | ...... |  | |  +-------------------+ |
> > +   +---------+ |  +-------+    | X_DSDT |--+ |  | Definition Blocks | |
> > +   | Pointer |-+  | ..... |    | ...... |    |  +-------------------+ |
> > +   +---------+    +-------+    +--------+    |  +-------------------+ |
> > +                  | Entry |------------------|->|       SSDT        | |
> > +                  +- - - -+                  |  +-------------------| |
> > +                  | Entry | - - - - - - - -+ |  | Definition Blocks | |
> > +                  +- - - -+                | |  +-------------------+ |
> > +                                          | |  +- - - - - - - - - -+ |
> > +                                          +-|->|       SSDT        | |
> > +                                             |  +-------------------+ |
> > +                                             |  | Definition Blocks | |
> > +                                             |  +- - - - - - - - - -+ |
> > +                                             +------------------------+
> > +                                                         |
> > +                                             OSPM Loading |
> > +                                                         \|/
> > +                                                   +----------------+
> > +                                                   | ACPI Namespace |
> > +                                                   +----------------+
> > +
> > +                  Figure 1. ACPI Definition Blocks
> > +
> > +.. note:: RSDP can also contain a pointer to the RSDT (Root System
> > +   Description Table).  Platforms provide RSDT to enable
> > +   compatibility with ACPI 1.0 operating systems.  The OS is expected
> > +   to use XSDT, if present.
> > +
> > +
> > +Example ACPI Namespace
> > +======================
> > +
> > +All definition blocks are loaded into a single namespace.  The namespace
> > +is a hierarchy of objects identified by names and paths.
> > +The following naming conventions apply to object names in the ACPI
> > +namespace:
> >  
> > -Copyright (C) 2013, Intel Corporation
> > -Author: Lv Zheng <lv.zheng@intel.com>
> > -
> > -
> > -Abstract:
> > -
> > -The Linux ACPI subsystem converts ACPI namespace objects into a Linux
> > -device tree under the /sys/devices/LNXSYSTEM:00 and updates it upon
> > -receiving ACPI hotplug notification events.  For each device object in this
> > -hierarchy there is a corresponding symbolic link in the
> > -/sys/bus/acpi/devices.
> > -This document illustrates the structure of the ACPI device tree.
> > -
> > -
> > -Credit:
> > -
> > -Thanks for the help from Zhang Rui <rui.zhang@intel.com> and Rafael J.
> > -Wysocki <rafael.j.wysocki@intel.com>.
> > -
> > -
> > -1. ACPI Definition Blocks
> > -
> > -   The ACPI firmware sets up RSDP (Root System Description Pointer) in the
> > -   system memory address space pointing to the XSDT (Extended System
> > -   Description Table).  The XSDT always points to the FADT (Fixed ACPI
> > -   Description Table) using its first entry, the data within the FADT
> > -   includes various fixed-length entries that describe fixed ACPI features
> > -   of the hardware.  The FADT contains a pointer to the DSDT
> > -   (Differentiated System Descripition Table).  The XSDT also contains
> > -   entries pointing to possibly multiple SSDTs (Secondary System
> > -   Description Table).
> > -
> > -   The DSDT and SSDT data is organized in data structures called definition
> > -   blocks that contain definitions of various objects, including ACPI
> > -   control methods, encoded in AML (ACPI Machine Language).  The data block
> > -   of the DSDT along with the contents of SSDTs represents a hierarchical
> > -   data structure called the ACPI namespace whose topology reflects the
> > -   structure of the underlying hardware platform.
> > -
> > -   The relationships between ACPI System Definition Tables described above
> > -   are illustrated in the following diagram.
> > -
> > -     +---------+    +-------+    +--------+    +------------------------+
> > -     |  RSDP   | +->| XSDT  | +->|  FADT  |    |  +-------------------+ |
> > -     +---------+ |  +-------+ |  +--------+  +-|->|       DSDT        | |
> > -     | Pointer | |  | Entry |-+  | ...... |  | |  +-------------------+ |
> > -     +---------+ |  +-------+    | X_DSDT |--+ |  | Definition Blocks | |
> > -     | Pointer |-+  | ..... |    | ...... |    |  +-------------------+ |
> > -     +---------+    +-------+    +--------+    |  +-------------------+ |
> > -                    | Entry |------------------|->|       SSDT        | |
> > -                    +- - - -+                  |  +-------------------| |
> > -                    | Entry | - - - - - - - -+ |  | Definition Blocks | |
> > -                    +- - - -+                | |  +-------------------+ |
> > -                                             | |  +- - - - - - - - - -+ |
> > -                                             +-|->|       SSDT        | |
> > -                                               |  +-------------------+ |
> > -                                               |  | Definition Blocks | |
> > -                                               |  +- - - - - - - - - -+ |
> > -                                               +------------------------+
> > -                                                           |
> > -                                              OSPM Loading |
> > -                                                          \|/
> > -                                                    +----------------+
> > -                                                    | ACPI Namespace |
> > -                                                    +----------------+
> > -
> > -                     Figure 1. ACPI Definition Blocks
> > -
> > -   NOTE: RSDP can also contain a pointer to the RSDT (Root System
> > -         Description Table).  Platforms provide RSDT to enable
> > -         compatibility with ACPI 1.0 operating systems.  The OS is expected
> > -         to use XSDT, if present.
> > -
> > -
> > -2. Example ACPI Namespace
> > -
> > -   All definition blocks are loaded into a single namespace.  The namespace
> > -   is a hierarchy of objects identified by names and paths.
> > -   The following naming conventions apply to object names in the ACPI
> > -   namespace:
> >     1. All names are 32 bits long.
> >     2. The first byte of a name must be one of 'A' - 'Z', '_'.
> >     3. Each of the remaining bytes of a name must be one of 'A' - 'Z', '0'
> > @@ -91,7 +94,7 @@ Wysocki <rafael.j.wysocki@intel.com>.
> >        (i.e. names prepended with '^' are relative to the parent of the
> >        current namespace node).
> >  
> > -   The figure below shows an example ACPI namespace.
> > +The figure below shows an example ACPI namespace::
> >  
> >     +------+
> >     | \    |                     Root
> > @@ -184,19 +187,20 @@ Wysocki <rafael.j.wysocki@intel.com>.
> >                       Figure 2. Example ACPI Namespace
> >  
> >  
> > -3. Linux ACPI Device Objects
> > +Linux ACPI Device Objects
> > +=========================
> >  
> > -   The Linux kernel's core ACPI subsystem creates struct acpi_device
> > -   objects for ACPI namespace objects representing devices, power resources
> > -   processors, thermal zones.  Those objects are exported to user space via
> > -   sysfs as directories in the subtree under /sys/devices/LNXSYSTM:00.  The
> > -   format of their names is <bus_id:instance>, where 'bus_id' refers to the
> > -   ACPI namespace representation of the given object and 'instance' is used
> > -   for distinguishing different object of the same 'bus_id' (it is
> > -   two-digit decimal representation of an unsigned integer).
> > +The Linux kernel's core ACPI subsystem creates struct acpi_device
> > +objects for ACPI namespace objects representing devices, power resources
> > +processors, thermal zones.  Those objects are exported to user space via
> > +sysfs as directories in the subtree under /sys/devices/LNXSYSTM:00.  The
> > +format of their names is <bus_id:instance>, where 'bus_id' refers to the
> > +ACPI namespace representation of the given object and 'instance' is used
> > +for distinguishing different object of the same 'bus_id' (it is
> > +two-digit decimal representation of an unsigned integer).
> >  
> > -   The value of 'bus_id' depends on the type of the object whose name it is
> > -   part of as listed in the table below.
> > +The value of 'bus_id' depends on the type of the object whose name it is
> > +part of as listed in the table below::
> >  
> >                  +---+-----------------+-------+----------+
> >                  |   | Object/Feature  | Table | bus_id   |
> > @@ -226,10 +230,11 @@ Wysocki <rafael.j.wysocki@intel.com>.
> >  
> >                   Table 1. ACPI Namespace Objects Mapping
> >  
> > -   The following rules apply when creating struct acpi_device objects on
> > -   the basis of the contents of ACPI System Description Tables (as
> > -   indicated by the letter in the first column and the notation in the
> > -   second column of the table above):
> > +The following rules apply when creating struct acpi_device objects on
> > +the basis of the contents of ACPI System Description Tables (as
> > +indicated by the letter in the first column and the notation in the
> > +second column of the table above):
> > +
> >     N:
> >        The object's source is an ACPI namespace node (as indicated by the
> >        named object's type in the second column).  In that case the object's
> > @@ -249,13 +254,14 @@ Wysocki <rafael.j.wysocki@intel.com>.
> >        struct acpi_device object with LNXVIDEO 'bus_id' will be created for
> >        it.
> >  
> > -   The third column of the above table indicates which ACPI System
> > -   Description Tables contain information used for the creation of the
> > -   struct acpi_device objects represented by the given row (xSDT means DSDT
> > -   or SSDT).
> > +The third column of the above table indicates which ACPI System
> > +Description Tables contain information used for the creation of the
> > +struct acpi_device objects represented by the given row (xSDT means DSDT
> > +or SSDT).
> > +
> > +The forth column of the above table indicates the 'bus_id' generation
> > +rule of the struct acpi_device object:
> >  
> > -   The forth column of the above table indicates the 'bus_id' generation
> > -   rule of the struct acpi_device object:
> >     _HID:
> >        _HID in the last column of the table means that the object's bus_id
> >        is derived from the _HID/_CID identification objects present under
> > @@ -275,45 +281,47 @@ Wysocki <rafael.j.wysocki@intel.com>.
> >        object's bus_id.
> >  
> >  
> > -4. Linux ACPI Physical Device Glue
> > -
> > -   ACPI device (i.e. struct acpi_device) objects may be linked to other
> > -   objects in the Linux' device hierarchy that represent "physical" devices
> > -   (for example, devices on the PCI bus).  If that happens, it means that
> > -   the ACPI device object is a "companion" of a device otherwise
> > -   represented in a different way and is used (1) to provide configuration
> > -   information on that device which cannot be obtained by other means and
> > -   (2) to do specific things to the device with the help of its ACPI
> > -   control methods.  One ACPI device object may be linked this way to
> > -   multiple "physical" devices.
> > -
> > -   If an ACPI device object is linked to a "physical" device, its sysfs
> > -   directory contains the "physical_node" symbolic link to the sysfs
> > -   directory of the target device object.  In turn, the target device's
> > -   sysfs directory will then contain the "firmware_node" symbolic link to
> > -   the sysfs directory of the companion ACPI device object.
> > -   The linking mechanism relies on device identification provided by the
> > -   ACPI namespace.  For example, if there's an ACPI namespace object
> > -   representing a PCI device (i.e. a device object under an ACPI namespace
> > -   object representing a PCI bridge) whose _ADR returns 0x00020000 and the
> > -   bus number of the parent PCI bridge is 0, the sysfs directory
> > -   representing the struct acpi_device object created for that ACPI
> > -   namespace object will contain the 'physical_node' symbolic link to the
> > -   /sys/devices/pci0000:00/0000:00:02:0/ sysfs directory of the
> > -   corresponding PCI device.
> > -
> > -   The linking mechanism is generally bus-specific.  The core of its
> > -   implementation is located in the drivers/acpi/glue.c file, but there are
> > -   complementary parts depending on the bus types in question located
> > -   elsewhere.  For example, the PCI-specific part of it is located in
> > -   drivers/pci/pci-acpi.c.
> > -
> > -
> > -5. Example Linux ACPI Device Tree
> > -
> > -   The sysfs hierarchy of struct acpi_device objects corresponding to the
> > -   example ACPI namespace illustrated in Figure 2 with the addition of
> > -   fixed PWR_BUTTON/SLP_BUTTON devices is shown below.
> > +Linux ACPI Physical Device Glue
> > +===============================
> > +
> > +ACPI device (i.e. struct acpi_device) objects may be linked to other
> > +objects in the Linux' device hierarchy that represent "physical" devices
> > +(for example, devices on the PCI bus).  If that happens, it means that
> > +the ACPI device object is a "companion" of a device otherwise
> > +represented in a different way and is used (1) to provide configuration
> > +information on that device which cannot be obtained by other means and
> > +(2) to do specific things to the device with the help of its ACPI
> > +control methods.  One ACPI device object may be linked this way to
> > +multiple "physical" devices.
> > +
> > +If an ACPI device object is linked to a "physical" device, its sysfs
> > +directory contains the "physical_node" symbolic link to the sysfs
> > +directory of the target device object.  In turn, the target device's
> > +sysfs directory will then contain the "firmware_node" symbolic link to
> > +the sysfs directory of the companion ACPI device object.
> > +The linking mechanism relies on device identification provided by the
> > +ACPI namespace.  For example, if there's an ACPI namespace object
> > +representing a PCI device (i.e. a device object under an ACPI namespace
> > +object representing a PCI bridge) whose _ADR returns 0x00020000 and the
> > +bus number of the parent PCI bridge is 0, the sysfs directory
> > +representing the struct acpi_device object created for that ACPI
> > +namespace object will contain the 'physical_node' symbolic link to the
> > +/sys/devices/pci0000:00/0000:00:02:0/ sysfs directory of the
> > +corresponding PCI device.
> > +
> > +The linking mechanism is generally bus-specific.  The core of its
> > +implementation is located in the drivers/acpi/glue.c file, but there are
> > +complementary parts depending on the bus types in question located
> > +elsewhere.  For example, the PCI-specific part of it is located in
> > +drivers/pci/pci-acpi.c.
> > +
> > +
> > +Example Linux ACPI Device Tree
> > +=================================
> > +
> > +The sysfs hierarchy of struct acpi_device objects corresponding to the
> > +example ACPI namespace illustrated in Figure 2 with the addition of
> > +fixed PWR_BUTTON/SLP_BUTTON devices is shown below::
> >  
> >     +--------------+---+-----------------+
> >     | LNXSYSTEM:00 | \ | acpi:LNXSYSTEM: |
> > @@ -377,12 +385,14 @@ Wysocki <rafael.j.wysocki@intel.com>.
> >  
> >                    Figure 3. Example Linux ACPI Device Tree
> >  
> > -   NOTE: Each node is represented as "object/path/modalias", where:
> > -         1. 'object' is the name of the object's directory in sysfs.
> > -         2. 'path' is the ACPI namespace path of the corresponding
> > -            ACPI namespace object, as returned by the object's 'path'
> > -            sysfs attribute.
> > -         3. 'modalias' is the value of the object's 'modalias' sysfs
> > -            attribute (as described earlier in this document).
> > -   NOTE: N/A indicates the device object does not have the 'path' or the
> > -         'modalias' attribute.
> > +.. note:: Each node is represented as "object/path/modalias", where:
> > +
> > +   1. 'object' is the name of the object's directory in sysfs.
> > +   2. 'path' is the ACPI namespace path of the corresponding
> > +      ACPI namespace object, as returned by the object's 'path'
> > +      sysfs attribute.
> > +   3. 'modalias' is the value of the object's 'modalias' sysfs
> > +      attribute (as described earlier in this document).
> > +
> > +.. note:: N/A indicates the device object does not have the 'path' or the
> > +   'modalias' attribute.
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
