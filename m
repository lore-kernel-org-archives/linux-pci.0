Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754500AbdBGOvz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Feb 2017 09:51:55 -0500
Date: Tue, 7 Feb 2017 14:51:48 +0000
From: Juri Lelli <juri.lelli@arm.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        Sudeep Holla <sudeep.holla@arm.com>, juri.lelli@arm.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Paolo Valente <paolo.valente@unimore.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux Kernel
 (OSPM-summit)
Message-ID: <20170207145148.GA18354@e106622-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Power Management and Scheduling in the Linux Kernel (OSPM-summit)
April 3-4, 2017
Scuola Superiore Sant'Anna (SSSA)
Pisa, Italy

http://retis.sssup.it/ospm-summit/
---

.:: FOCUS

Power management and scheduling techniques to reduce energy consumption while
meeting performance and latency requirements are receiving considerable
attention from the Linux Kernel development community. 

The Power Management and Scheduling in the Linux Kernel (OSPM-summit) summit
aims at fostering further interest and discussion to happen.

.:: FORMAT

The summit is organized to cover two days of discussions and talks.

First day is mainly focused on discussion and hacking sessions about
topics/patches that are already under review in the Linux kernel mailing lists
and to debate and plan development tasks for more forward looking work items
centred around power management in the Linux kernel. The list of topics
includes (but it is not limited to):

* Energy Aware Scheduling: next steps and energy model expression;
* SCHED_DEADLINE reclaiming of unused bandwidth, coupling with schedutil
  cpufreq governor and group scheduling support;
* fix the load metric exposed to cpuidle;
* IRQ prediction;
* ACPI power management: kernel/firmware bindings and development model;

Second day instead welcomes presentations from both end users and developers on
topics about Power management and scheduling in Linux covering, but not limited
to:

* Power management techniques
* Real-time and non real-time scheduling techniques
* Energy awareness
* Mobile/Server power management real-world use cases (successes and
  failures)
* Power management and scheduling tooling (tracing, configuration,
  integration testing, etc.)

Presentations can cover recently developed technologies, ongoing work and new
ideas. Please understand that this workshop is not intended for presenting
sales and marketing pitches.

.:: ATTENDING

Attending the OSPM-summit is free of charge, but registration to the event is
mandatory. The event can allow a maximum of 50 people (so, be sure to register
early!). To register send an email to ospm-registration@retis.sssup.it. While
it is not strictly required to submit a topic/presentation, registrations with
a topic/presentation proposal will take precedence.

.:: VENUE

The workshop will take place at ReTiS Lab*, Scuola Superiore Sant'Anna, Pisa,
Italy. Pisa is a small town, walking distance from the city center to the venue
is 20 minutes, walking distance from the airport to the city center is 30
minutes. More details are available from the summit web page:
http://retis.sssup.it/ospm-summit/

* https://goo.gl/maps/2pPXG2v7Lfp

.:: SUBMIT A TOPIC/PRESENTATION

To submit a topic/presentation send an email to
ospm-registration@retis.sssup.it specifying:

 subject
  - [TOPIC] or [PRESENTATION]
  - short title

 body
  - first name, family name
  - abstract/topic of interest
  - affiliation (if any)
  - short biography
  - expected duration (only for topics, presentations get 30min slots)

Deadline for submitting topics/presentations is 26th of February 2017.
Notifications for accepted topics/presentations will be sent out on 5th of
March 2017.

.:: ORGANIZERS (in alphabetical order)

Luca Abeni (SSSA)
Patrick Bellasi (ARM)
Tommaso Cucinotta (SSSA)
Dietmar Eggemann (ARM)
Sudeep Holla (ARM)
Juri Lelli (ARM)
Lorenzo Pieralisi (ARM)
Morten Rasmussen (ARM)
